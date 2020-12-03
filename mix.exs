defmodule AdventOfCodeHelper.Mixfile do
  use Mix.Project

  def project do
    [
      app: :advent_of_code_helper,
      version: "0.2.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      preferred_cli_env: [
        vcr: :test,
        "vcr.delete": :test,
        "vcr.show": :test,
        "vcr.check": :test,
        coveralls: :test,
        "coveralls.html": :test,
        "coveralls.json": :test,
      ],
      test_coverage: [tool: ExCoveralls],
    ]
  end

  # Run "mix help compile.app" to learn about applications.

  # Run "mix help deps" to learn about dependencies.
  defp deps do
   [
     {:exvcr, "~> 0.12", only: :test},
     {:finch, "~> 0.5"},
     {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
     {:excoveralls, "~> 0.13", only: :test},
     {:ex_doc, ">=0.0.0", only: :dev, runtime: false},
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
      files: ["lib","mix.exs","config/config.exs.sample","README*","LICENSE"],
      maintainers: ["Edward Hobbs"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/ejhobbs/Advent-Of-Code"}
    ]
  end

end
