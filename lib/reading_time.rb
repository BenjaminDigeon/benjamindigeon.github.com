# Outputs the reading time
# ex: "3 minutes read"
# Source : http://torspark.com/how-to-calculate-article-reading-time-with-a-custom-middleman-extension/

class ReadingTime < Middleman::Extension
  def initialize(app, options_hash={}, &block)
    super
  end

  helpers do
    def reading_time(input)
      words_per_minute = 180

      words = input.split.size
      minutes = (words / words_per_minute).floor
      minutes_label = minutes === 1 ? ' minute' : ' minutes'
      minutes > 0 ? "#{minutes} #{minutes_label} read" : 'less than 1 minute read'
    end
  end
end

::Middleman::Extensions.register(:reading_time, ReadingTime)
