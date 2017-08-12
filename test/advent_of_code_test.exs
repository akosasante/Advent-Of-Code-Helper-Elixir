defmodule AdventOfCodeHelperTest do
  use ExUnit.Case
  import Double

  test "do we get the correct value" do
    stub = AdventOfCodeHelper.GetInputs
           |> double
           |> allow(:get_value, fn(_y,_d,session,_hm) -> {:ok, session} end)
    {:ok, contents} = AdventOfCodeHelper.get_input(2015,1,stub)
    assert contents == Application.get_env(:advent_of_code, :session)
    assert_receive({:get_value, 2015, 1, nil})
  end

end
