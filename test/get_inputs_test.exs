defmodule GetInputsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock

  setup _context do
    File.mkdir(".cache")
    File.write(".cache/input_2016_2", "test_post_pls_ignore", [])

    on_exit fn ->
      File.rm_rf(".cache/")
    end
    {:ok, [id: "53616c7465645f5fb35d2e8e7973229fde2a3e9651ee924da36341f3f3c282b826575283cf90a7bf183048ec5a1a1614", url: "http://adventofcode.com/2015/day/1/input", content: ~r/\)\(\)\(\(\(\(\(\(\(\)\(\)\)\)\)\)\(\)\(\)\(\(\(\(\)\(/, cached_content: "test_post_pls_ignore"]}
  end

  setup_all do
    ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes")
    :ok
  end

  test "does it run", context do
    use_cassette("whole_chain") do
      {:ok, body} = GetInputs.get_value(2015,1,context[:id])
      assert body =~ context[:content]
    end
  end

  test "can it make http requests", context do
    use_cassette("makerequest_valid") do
      {:ok, values} = GetInputs.get_from_url(context[:url], context[:id])
      assert values =~ context[:content]
    end
  end

  test "invalid context should fail", context do 
    use_cassette("makerequest_invalid_context") do 
      assert {:fail, _values} = GetInputs.get_from_url(context[:url], "veryinvalid")
    end
  end

  test "invalid url should fail" do 
    use_cassette("makerequest_invalid_url") do
      assert {:fail, _values} = GetInputs.get_from_url("http://adventofcode.com/2015/day/1/inasput","i dont matter")
    end
  end

  test "generate valid url", context do
    url = GetInputs.generate_url(2015,1)
    assert url == context[:url]
  end

  test "cache hit should bypass http", context do
    use_cassette("makerequest_alreadycached") do
      {:ok, contents} = GetInputs.get_value(2016,2,context[:id])
      assert contents = context[:cached_content]
    end
  end

  test "non-cached result should be stored after get", context do
    use_cassette("non-cached_request") do
      {:ok, contents} = GetInputs.get_value(2015,1,context[:id])
      assert File.exists?(".cache/input_2015_1")
    end
  end
end
