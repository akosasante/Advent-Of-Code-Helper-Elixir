# This file is responsible for configuring your application and its dependencies
import Config

config :advent_of_code_helper,
  session: System.get_env("AOC_SESSION"),
  cache_dir: ".cache/"

import_config "#{config_env()}.exs"
