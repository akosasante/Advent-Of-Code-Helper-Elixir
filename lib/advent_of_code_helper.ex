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

end
