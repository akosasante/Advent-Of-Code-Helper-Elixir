# Advent of Code Elixir

This elixir package allows you to quickly grab inputs for advent of code puzzles, and not have to worry about manually pasting them in!

## Usage

There are only two functions you need to use this module:

```elixir
AdventOfCode.get_input(year,day) # Specify year and day for puzzle

AdventOfCode.get_input(day) # Automatically gets puzzle from most recent year

```
Both of these functions will simply return a tuple `{:ok, value}` if they succeed, where `value` is the puzzle input in the form of a `BitString`, or `{:fail, message}` if there was something wrong.

There are two configuration directives that are also needed to make this package work correctly. Simply add the following to your `config/config.exs`

```elixir
config: :advent_of_code,
session: "<session string>",
cache_dir: ".cache/" # this is a sensible default, but feel free to put it wherever you have write access
```

The session string will need to be taken from ![adventofcode.com](https://adventofcode.com), it will be under cookies as `session`. You can extract the value using the inspector in your browser of choice.


## Installation

This package can be installed by adding `advent_of_code` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:advent_of_code_2015, "~> 0.1.0"}
  ]
end
```
