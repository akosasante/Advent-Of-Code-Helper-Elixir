defmodule Mix.Tasks.Advent.RunDay do
  @moduledoc """
  Mix task run with the command: `mix advent.run_day day=<day> year=<year> bench=<boolean> split=<splitOption> sep=<sep> trim=<boolean>`
  It will run the `part1/1` and `part2/1` functions in the module associated with a given day's Advent puzzle.
  """

  use Mix.Task

  @shortdoc "Run the input for a given day's advent challenge"

  @impl Mix.Task
  def run(args) do
    Mix.Task.run("app.start")
    year = get_year(args)
    day = get_day(args)
    bench = get_benchmark_flag(args)
    sep = get_separator(args)
    split = get_split_opt(args)
    trim = get_trim(args)

    run_day(year, day, bench, sep, split, trim)
  end

  defp run_day(year, day, bench, sep, split, trim) do
    module_name = Module.concat("Advent#{year}", "Day#{day}")

    input =
      AdventOfCodeHelper.get_input(year, day)
      |> conditionally_split(split, sep, trim)

    if bench do
      System.put_env("PRINT_LOGS", "false")

      Benchee.run(
        %{
          "Part 1" => fn -> apply(module_name, :part1, [input]) end,
          "Part 2" => fn -> apply(module_name, :part2, [input]) end
        },
        print: %{benchmarking: false, configuration: false}
      )
    else
      System.put_env("PRINT_LOGS", "true")

      p1_answer = apply(module_name, :part1, [input])
      p2_answer = apply(module_name, :part2, [input])

      IO.puts("""


      Day #{day}:
      ----------------------------
      Part 1:
      #{p1_answer}


      Part 2:
      #{p2_answer}

      ----------------------------
      """)
    end
  end

  defp get_year(args) do
    case Enum.find(args, &String.starts_with?(&1, "year=")) do
      "year=" <> year -> String.to_integer(year)
      _ -> AdventOfCodeHelper.calculate_year()
    end
  end

  defp get_day(args) do
    case Enum.find(args, &String.starts_with?(&1, "day=")) do
      "day=" <> day -> String.to_integer(day)
      _ -> raise "Must include day= argument"
    end
  end

  defp get_benchmark_flag(args) do
    case Enum.find(args, &String.starts_with?(&1, "bench=")) do
      "bench=" <> bench when bench in ["false", "true"] -> String.to_atom(bench)
      nil -> false
      _ -> raise "If included, bench= argument can only have the values of `true` or `false`"
    end
  end

  defp get_separator(args) do
    case Enum.find(args, &String.starts_with?(&1, "sep=")) do
      "sep=" <> sep -> sep
      _ -> "\n"
    end
  end

  defp get_split_opt(args) do
    case Enum.find(args, &String.starts_with?(&1, "split=")) do
      "split=" <> split when split in ["false"] -> String.to_atom(split)
      "split=list" -> "list"
      "split=stream" -> "stream"
      _ -> "list"
    end
  end

  defp get_trim(args) do
    case Enum.find(args, &String.starts_with?(&1, "trim=")) do
      "trim=" <> trim when trim in ["true", "false"] -> String.to_atom(trim)
      _ -> false
    end
  end

  defp conditionally_split({:ok, input}, false, _sep, _trim) do
    input
  end

  defp conditionally_split({:ok, input}, "list", sep, trim) do
    AdventOfCodeHelper.split_to_list(input, sep, trim)
  end

  defp conditionally_split({:ok, input}, "stream", sep, trim) do
    AdventOfCodeHelper.split_to_stream(input, sep, trim)
  end

  defp conditionally_split(input_failed_responce, _split_opt, _sep, _trim) do
    IO.puts("Failed to fetch and parse puzzle input: #{inspect(input_failed_responce)}")
    nil
  end
end
