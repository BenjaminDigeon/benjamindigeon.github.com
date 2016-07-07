---
title: Overlapping issues with time slots in Ruby
date: 2016-01-29
tags: Ruby RubyOnRails
published: true
reading_time: 5
---

When i was working for a client on a Ruby on Rails application dealing with multiples time slots,
i find myself with a rather complex problem.

## Time Slots

To manage user schedules, the application has an object `TimeSlot` which represents a period of time between `start_date` and `end_date`.

```ruby
class TimeSlot < ActiveRecord::Base
  belongs_to :user
  attr_accessible :end_date, :start_date
end
```

Simple enough right ? But the user can have several `TimeSlot` at the same time, and of course it can midway between two days.

And i need to calculate the number of hours used by days.

But i have a main problem : Overlapping time slots.

## Overlapping Issue

### Range of DateTime

Luckily we can solve this rather complex problem using the ruby
[Range](http://ruby-doc.org/core-1.9.3/Range.html) class.

> A Range represents an interval—a set of values with a start and an end.
>
> Ranges can be constructed using objects of any type, as long as the objects
> can be compared using their <=> operator and they support the succ method
> to return the next object in sequence.


So we can convert all ours `TimeSlot` objects into `Range` of `DateTime` with a little helper.

```ruby
def to_time_range
  (self.start_date..self.end_date)
end
```

We're going to need some utility methods for check if a range overlap another
and for merging two range together.

```ruby
def ranges_overlap?(a, b)
  a.cover?(b.begin) || b.cover?(a.begin)
end

def merge_ranges(a, b)
  [a.begin, b.begin].min..[a.end, b.end].max
end
```

Now we just need to check inside the array of ranges, if some range overlap another and merge it.

```ruby
def merge_overlapping_ranges(ranges)
  ranges.sort_by(&:begin).inject([]) do |ranges, range|
    if !ranges.empty? && ranges_overlap?(ranges.last, range)
      ranges[0...-1] + [merge_ranges(ranges.last, range)]
    else
      ranges + [range]
    end
  end
end
```

Thank to this [thread on Stackoverflow](http://stackoverflow.com/a/6018744/1361310).
