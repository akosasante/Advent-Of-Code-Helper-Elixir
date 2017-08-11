defmodule AdventOfCodeHelperTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock
  import Mock

  setup_all do
    ExVCR.Config.cassette_library_dir("test/fixture/vcr_cassettes")
    :ok
  end


  test "do we get the correct value" do
    use_cassette("everything_should_work") do
      {:ok, contents} = AdventOfCodeHelper.get_input(2015,1)
      assert String.length(contents) == 7000
    end
  end

  test "gets current year correctly" do
    use_cassette("most_recent_year") do
      {:ok, _contents} = AdventOfCodeHelper.get_input(1)
      assert File.exists?(".cache/input_#{calculate_year()}_1")
    end
  end

  test "gets current year correctly in december" do
    use_cassette("2016_day_2") do
      with_mock Date, [utc_today: fn() -> ~D[2016-12-02] end] do
        {:ok, _contents} = AdventOfCodeHelper.get_input(2)
        assert File.exists?(".cache/input_#{calculate_year()}_1")
      end
    end
  end

  defp calculate_year do
    today = Date.utc_today
    case today.month < 12 do
      true -> today.year-1
      false -> today.year
    end
  end
end
