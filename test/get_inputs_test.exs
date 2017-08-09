defmodule GetInputsTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock

  setup_all _context do
    cache_dir = Application.get_env(:advent_of_code, :cache_dir)

    File.mkdir(cache_dir)
    File.write(Path.join(cache_dir,"input_2016_2"), "test_post_pls_ignore", [])

    on_exit fn ->
      File.rm_rf(cache_dir)
    end

    {:ok, [id: Application.get_env(:advent_of_code, :session), content_length: 7000, cached_content: "test_post_pls_ignore", cache_dir: cache_dir]}
  end

  setup_all do
    ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes")
    :ok
  end

  test "does it run", context do
    use_cassette("whole_chain") do
      {:ok, body} = GetInputs.get_value(2015,1,context[:id])
      assert String.length(body) == context[:content_length]
    end
  end

 test "cache hit should bypass http", context do
    use_cassette("makerequest_alreadycached") do
      {:ok, contents} = GetInputs.get_value(2016,2,context[:id])
      assert contents == context[:cached_content]
    end
  end

  test "non-cached result should be stored after get", context do
    use_cassette("non-cached_request") do
      {:ok, _contents} = GetInputs.get_value(2015,1,context[:id])
      assert File.exists?("#{Path.join(context[:cache_dir],"input_2015_1")}")
    end
  end
end
