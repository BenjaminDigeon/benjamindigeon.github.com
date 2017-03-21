---
title: Elixir and Phoenix, a little journey inside functional programming - Part 1
date: 2017-03-10
tags: Elixir, Phoenix
published: false
reading_time: 2
---

![elixir-logo](/assets/images/blog/2017-03-10-elixir-and-phoenix-part1/elixir-logo.png)

A few month ago i started a new personnal project with [Elixir](http://elixir-lang.org/) and [Phoenix](http://www.phoenixframework.org/).

It was for me the opportunity to try a new web framework, after almost 5 years working and a little more than one year teaching Ruby and Rails.

Before seeing in more detail Phoenix, let's talk a little about Elixir.

# Elixir

What it's Elixir :

> Elixir is a **functional**, **concurrent**, general-purpose **programming language** that runs on the **Erlang virtual machine** (BEAM).
>
>[Wikipedia](https://en.wikipedia.org/wiki/Elixir_(programming_language))

The first thing to inderstand about Elixir is that it is a **functional programming language** quite different from a imperative language.

Functional programming treats computation as the evaluation of functions, and avoids mutable state and data.

## Installation

For installing Elixir go to [the website](http://elixir-lang.org/install.html) and follow the well thought guide.

For macOS just install it with [homebrew](https://brew.sh/) :

```bash
brew install elixir
```

Then you can open `iex` inside a terminal just like `irb` in Ruby.

```bash
$ iex
Erlang/OTP 19 [erts-8.2] [source] [64-bit] [smp:4:4] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]

Interactive Elixir (1.4.2) - press Ctrl+C to exit (type h() ENTER for help)
```
`iex` stands for **Interactive Elixir**. In `iex` you can type any expression and you will get a result back:

```elixir
iex(1)> 1+1
2
iex(2)>
```

## Lets go througt some code

Let's see a very basic example :

```elixir
# example.exs
# This is a code comment
text = "hello" <> " world"
IO.puts text
```

First, there are 2 types of file extension for elixir `.ex` is for compiled code, `.exs` is for interpreted code.

Tests, for example, are in `.exs` files so that you don't have to recompile every time you make a change to your tests. If you're writing scripts or tests, use `.exs` files. Otherwise, just use `.ex` files and compile your code.

As far as performances, interpretation will take longer to execute (as elixir has to parse, tokenize, etc.), but doesn't require compilation to run.

Writing a code comment is exactly like ruby with the comment started by `#`.

The we have `text = "hello" <> " world"` with look like a variable assignment and a concatenation of String.

But is not, **really not !**

It's a little more complex, the `=` operator in Elixir is the **match operator**. It enables us to assign and then match values.

Let’s take a look:

```elixir
iex(1)> {a, b} = {:hello, "world"}
{:hello, "world"}
iex(2)> a
:hello
iex(3)> "world" = a
** (MatchError) no match of right hand side value: :hello
```

This is one of the most important things to remember about functional programming.

<div class="center">
<blockquote class="twitter-tweet" data-lang="fr">
<p lang="en" dir="ltr">Every functional programming tutorial... <a href="https://t.co/ckE6cY4YFe">pic.twitter.com/ckE6cY4YFe</a></p>&mdash; I Am Devloper (@iamdevloper) <a href="https://twitter.com/iamdevloper/status/841650579533369344">14 mars 2017</a>
</blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8">
</script>
</div>
