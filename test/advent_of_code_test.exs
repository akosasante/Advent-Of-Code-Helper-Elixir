defmodule AdventOfCodeHelperTest do
  use ExUnit.Case

  test "do we get the correct value" do
    {:ok, contents} = AdventOfCodeHelper.get_input(2015,1)
    assert String.length(contents) == 7000
  end

end
