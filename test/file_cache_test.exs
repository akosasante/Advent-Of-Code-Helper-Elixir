defmodule AdventOfCodeHelper.FileCacheTest do
  alias AdventOfCodeHelper.FileCache
  use ExUnit.Case, async: false

  setup _context do
    cache_dir = Application.get_env(:advent_of_code_helper, :cache_dir)
    File.mkdir(cache_dir)
    File.write(Path.join(cache_dir, "input_test_day"), "test contents", [])

    on_exit(fn ->
      File.rm_rf(cache_dir)
    end)

    {:ok, [dir: cache_dir, contents: "test contents"]}
  end

  test "saves a file", context do
    FileCache.save_file(2015, 1, context[:contents])
    {:ok, contents} = File.read("#{context[:dir]}/input_2015_1")
    assert contents == context[:contents]
  end

  test "can load a file", context do
    {:ok, contents} = FileCache.get_file("test", "day")
    assert contents == context[:contents]
  end

  test "fail on non-existent file" do
    assert {:fail, _message} = FileCache.get_file(2016, 5)
  end

  test "should create cache dir if not already present", context do
    File.rm_rf(context[:dir])
    refute File.exists?(context[:dir])
    FileCache.save_file("dont", "care", "content")
    assert File.exists?(context[:dir])
  end
end
