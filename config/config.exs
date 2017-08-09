# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :advent_of_code,
session: System.get_env("AOC_SESSION"),
cache_dir: ".cache/"
