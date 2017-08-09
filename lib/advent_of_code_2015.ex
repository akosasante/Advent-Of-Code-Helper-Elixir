defmodule AdventOfCode2015 do
  def get_input(year,day) do
    GetInputs.(year,day,Application.get_env(:advent_of_code, :session))
  end
end
