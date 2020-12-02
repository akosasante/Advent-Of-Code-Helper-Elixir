defmodule AdventOfCodeHelperTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Httpc

  setup _context do
    cache_dir = Application.get_env(:advent_of_code_helper, :cache_dir)
    File.mkdir cache_dir
    File.write(Path.join(cache_dir,"input_test_day"),"test contents",[])

    on_exit fn ->
      File.rm_rf cache_dir
    end
    {:ok, [dir: cache_dir, contents: "test contents"]}
  end

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

  test "uses previous year if it's not december yet", context do
    defmodule NonDecemberDateModule do
      def utc_today(), do: ~D[2020-11-30]
    end

    Application.put_env(:advent_of_code_helper, :date_module, NonDecemberDateModule)

    use_cassette("most_recent_year") do
      {:ok, _contents} = AdventOfCodeHelper.get_input(1)
      assert File.exists?("#{context[:dir]}/input_2019_1")
    end
  end

  test "gets current year correctly in december", context do
    defmodule December2020DateModule do
      def utc_today(), do: ~D[2020-12-10]
    end

    Application.put_env(:advent_of_code_helper, :date_module, December2020DateModule)

    use_cassette("2016_day_2") do
      {:ok, _contents} = AdventOfCodeHelper.get_input(2)
      assert File.exists?("#{context[:dir]}/input_2020_2")
    end
  end
end
