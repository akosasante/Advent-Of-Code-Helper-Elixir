defmodule AdventOfCode.Mixfile do
  use Mix.Project

  def project do
    [
      app: :advent_of_code,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps(),
      preferred_cli_env: [
        "coveralls": :test,
        "coveralls.html": :test,
        "coveralls.json": :test,
      ],
test_coverage: [tool: ExCoveralls],
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [ applications: [:httpotion] ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
   [
      {:exvcr, "~> 0.8", only: :test},{:httpotion, "~> 3.0.2"},{:dialyxir, "~> 0.5", only: [:dev], runtime: false},{:excoveralls, "~> 0.7.2", only: :test}
   ]
  end

  defp description do
    """
    Package to allow you to get input for all advent of code puzzles, rather than
    pasting them in manually.
    """
  end

end
