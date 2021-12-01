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
  @spec get_input(integer(), integer()) :: {:ok, String.t()}
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

  defp calculate_year() do
    today = date_mod().utc_today()

    case today.month < 12 do
      true -> today.year - 1
      false -> today.year
    end
  end

  defp date_mod(), do: Application.get_env(:advent_of_code_helper, :date_module) || Date
end
