defmodule FileCacheTest do
  use ExUnit.Case

  setup _context do
    File.mkdir ".cache/"
    File.write(".cache/input_test_day","test contents",[])

    on_exit fn ->
      File.rm_rf ".cache"
    end
    {:ok, [dir: ".cache/", contents: "test contents"]}

  end

  test "saves a file", context do
    FileCache.save_file(2015,1,context[:contents])
    {:ok, contents} = File.read("#{context[:dir]}/input_2015_1")
    assert contents = context[:contents]
  end

  test "can load a file",context do
    {:ok, contents} = FileCache.get_file("test","day")
    assert contents = context[:contents]
  end

  test "fail on non-existent file" do
    {:fail, message} = FileCache.get_file(2016,5)
  end
end
