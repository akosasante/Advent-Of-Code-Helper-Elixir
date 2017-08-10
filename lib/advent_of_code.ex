defmodule AdventOfCode do
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
    GetInputs.get_value(year,day,Application.get_env(:advent_of_code, :session))
  end

  @doc """
  Return input values for most recent year

  ## Parameters
    - day: Int that represents day of puzzle
  """
  def get_input(day) do
    calculate_year() |> get_input(day)
  end

  defp calculate_year do
    today = Date.utc_today
    case today.month < 12 do
      true -> today.year-1
      false -> today.year
    end
  end
end
