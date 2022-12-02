defmodule AdventOfCodeHelper do
  alias AdventOfCodeHelper.GetInputs

  @moduledoc """
  Provides an interface to get input values for Advent of Code puzzles
  """

  @doc """
  Returns input values

  ## Parameters
    - year: Int that represents year of puzzle
    - day: Int that represents day of puzzle
  """
  @spec get_input(integer(), integer()) :: {:ok, String.t()} | {:fail, any()}
  def get_input(year, day) do
    GetInputs.get_value(year, day, Application.get_env(:advent_of_code_helper, :session))
  end

  @doc """
  Return input values for most recent year

  ## Parameters
    - day: Int that represents day of puzzle
  """
  @spec get_input(integer()) :: {:ok, String.t()}
  def get_input(day) do
    calculate_year() |> get_input(day)
  end

  @doc """
  Splits the string input into a list, using a given separator.
  """
  @spec split_to_list(String.t(), String.t()) :: list(any())
  def split_to_list(input, sep \\ "\n") do
    String.split(input, sep, trim: true)
  end

  @doc """
  Splits the string input into a stream, using a given separator.
  """
  @spec split_to_stream(String.t(), String.t()) :: Enumerable.t()
  def split_to_stream(input, sep \\ "\n") do
    Stream.flat_map(input, &String.split(&1, sep, trim: true))
  end

  def calculate_year() do
    today = date_mod().utc_today()

    case today.month < 12 do
      true -> today.year - 1
      false -> today.year
    end
  end

  defp date_mod(), do: Application.get_env(:advent_of_code_helper, :date_module) || Date
end
