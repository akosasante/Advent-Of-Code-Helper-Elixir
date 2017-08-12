defmodule AdventOfCodeHelperTest do
  use ExUnit.Case

  test "do we get the correct value" do
    stub = GetInputs
           |> double
           |> allow(:get_value, &({:ok, &3}))
    {:ok, contents} = AdventOfCodeHelper.get_input(2015,1)
    assert contents == Application.get_env(:advent_of_code, :session)
    assert_receive(:example, 2015}
  end

end
