# Advent of Code Helper [![Build Status](https://app.travis-ci.com/akosasante/Advent-Of-Code-Helper-Elixir.svg?branch=master)](https://travis-ci.org/ejhobbs/Advent-Of-Code) [![codecov](https://codecov.io/gh/akosasante/Advent-Of-Code-Helper-Elixir/branch/master/graph/badge.svg?token=vssP39GcoL)](https://codecov.io/gh/akosasante/Advent-Of-Code-Helper-Elixir) [![Hex.pm](https://img.shields.io/hexpm/v/advent_of_code_helper.svg?style=plastic)](https://hex.pm/packages/advent_of_code_helper) [![hexdocs.pm](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/advent_of_code_helper/api-reference.html)


This Elixir package allows you to quickly grab inputs for Advent of ode puzzles, and not have to worry about manually pasting them in! After you've got a puzzle input for the first time, the result is stored on disk so every subsequent request bypasses the need to download it from the server again.

## Usage

### Via Mix Tasks

There are two mix tasks included in this library: `advent.setup_day` and `advent.run_day`.

For creating a new directory and `.ex` file for a given Advent puzzle, use the setup command:

`mix advent.setup_day <year> <day>` or `mix advent.setup_day <day>` 

where year is a four-digit integer (eg: 2022) and day is a number between 1 and 25. Year will be inferred as the current year if it's not passed in. A folder will be created under the `lib` directory of the mix project, and a skeleton module will be generated.


To run the code you've added to the generated template file, use the run command:

`mix advent.run_day day=<day> year=<year> bench=<boolean> split=<splitOption> sep=<sep> trim=<boolean>`

Only `day` is a required argument. `Year` will be inferred as current year if it's not given, otherwise it should be a 4-digit number. 
If bench is `true`, the task will run the day's puzzles through [benchee](https://github.com/bencheeorg/benchee) and return the benchmark results.

By default, (if no `split` or `sep` options are passed in), the puzzle input will be read as a string, split on newlines, and the resulting list will be passed into the puzzle module to be run.
You can change this behaviour by passing in either `list`, `stream`, or `false` for split. This will split the string into a List, a Stream, or leave the input as-is, respectively. The separator to use as the split boundary can be changed by passing in a `sep` argument; trimming extra newlines/whitespace can be enabled by setting `trim` to `true`.


### Directly calling AdventOfCodeHelper

There are two main functions for fetching the puzzle input:

```elixir
AdventOfCodeHelper.get_input(year,day) # Specify year and day for puzzle

AdventOfCodeHelper.get_input(day) # Automatically gets puzzle from most recent year

```

Both of these functions will simply return a tuple `{:ok, value}` if they succeed, where `value` is the puzzle input in the form of a `String`, or `{:fail, message}` if there was something wrong.


You can also use the provided helpers for splitting the string input into a List or Stream: `split_to_list/2` and `split_to_stream/2`.


### Configuration

There are two configuration directives that are also needed to make this package work correctly. Simply add the following to your `config/config.exs`

```elixir
config :advent_of_code_helper,
session: "<session string>",
cache_dir: ".cache/" # this is a sensible default, but feel free to put it wherever you have write access
```

The session string will need to be taken from [adventofcode.com](https://adventofcode.com), it will be under cookies as `session`. You can extract the value using the inspector/devTools in your browser of choice.


## Installation

This package can be installed by adding `advent_of_code_helper` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:advent_of_code_helper, "~> 0.3.1"}
  ]
end
```
