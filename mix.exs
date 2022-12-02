defmodule AdventOfCodeHelper.Mixfile do
  use Mix.Project

  def project do
    [
      app: :advent_of_code_helper,
      version: "0.3.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      dialyzer: [plt_add_apps: [:mix]],
      package: package(),
      preferred_cli_env: [
        vcr: :test,
        "vcr.delete": :test,
        "vcr.show": :test,
        "vcr.check": :test,
        coveralls: :test,
        "coveralls.html": :test,
        "coveralls.json": :test
      ],
      test_coverage: [tool: ExCoveralls],
      # Docs
      name: "Advent of Code Elixir Helper",
      docs: [
        filter_modules: ~r/AdventOfCodeHelper$/,
        extras: ["README.md"]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:benchee, "~> 1.1.0"},
      {:finch, "~> 0.8.0"},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:excoveralls, "~> 0.14", only: :test},
      {:ex_doc, "~> 0.24", only: :dev, runtime: false},
      {:exvcr, "~> 0.13.2", only: :test}
    ]
  end

  defp description do
    """
    Package to allow you to get input for all advent of code puzzles, rather than
    pasting them in manually.
    """
  end

  defp package do
    [
      name: :advent_of_code_helper,
      files: ["lib", "mix.exs", "config/config.exs.sample", "README*", "LICENSE"],
      maintainers: ["Edward Hobbs", "Akosua Asante"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/akosasante/Advent-Of-Code-Helper-Elixir"}
    ]
  end
end
