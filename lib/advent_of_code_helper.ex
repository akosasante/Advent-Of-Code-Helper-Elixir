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
  def get_input(year,day) do
    GetInputs.get_value(year,day,Application.get_env(:advent_of_code_helper, :session))
  end

  @doc """
  Return input values for most recent year

  ## Parameters
    - day: Int that represents day of puzzle
  """
  def get_input(day, date_mod \\ Date) do
    calculate_year(date_mod) |> get_input(day)
  end

  defp calculate_year(date_mod) do
    today = date_mod.utc_today
    case today.month < 12 do
      true -> today.year-1
      false -> today.year
    end
  end
end
