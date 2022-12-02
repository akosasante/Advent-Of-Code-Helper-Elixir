defmodule Mix.Tasks.Advent.SetupDay do
  @moduledoc """
  Mix task run with the command: `mix advent.setup_day <year> <day>` or `mix advent.setup_day <day>`
  It will create a folder and template/starter file for a given day's Advent puzzle.
  """

  use Mix.Task

  @shortdoc "Create folder and starter file for given day's advent challenge"

  @impl Mix.Task
  def run([year, day]) do
    IO.puts("Generating file(s) for Advent #{year}, Day #{day}")
    file_path = Path.join(get_day_folder(day), "code.ex")

    File.write(
      file_path,
      skeleton_content(year, day)
    )
  end

  @impl Mix.Task
  def run([day]) do
    run([AdventOfCodeHelper.calculate_year(), day])
  end

  defp get_day_folder(day) do
    path = "lib/day#{day}"

    unless File.exists?(path) do
      File.mkdir(path)
    end

    path
  end

  defp skeleton_content(year, day) do
    """
    defmodule Advent#{year}.Day#{day} do
      require Logger

      def part1(input) do
        Logger.info("Running #{year}-#{day}-P1-InputList")
        IO.inspect(input, label: :input_for_day1, pretty: true)
        "Not implemented"
      end

      def part2(input) do
        Logger.info("Running #{year}-#{day}-P2-InputList")
        IO.inspect(input, label: :input_for_day2, pretty: true)
        "Not implemented"
      end
    end
    """
  end
end
