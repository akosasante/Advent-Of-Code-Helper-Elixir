defmodule AdventOfCodeHelper.FileCacheTest do
  alias AdventOfCodeHelper.FileCache
  use ExUnit.Case
  import Double

  test "saves a file", context do
    stub = File
           |> double
           |> allow(:exists?, fn(_file) -> true end)
           |> allow(:write, fn(filename,content,_opts) -> :ok end)
    {:ok, contents} = FileCache.save_file(2015,1,"test contents", stub)
    assert contents == "test contents"
    assert_received({:exists?, ".cache/"})
    assert_received({:write, ".cache/input_2015_1", "test_contents", []})
  end

  test "can load a file",context do
    {:ok, contents} = FileCache.get_file("test","day")
    assert contents == context[:contents]
  end

  test "fail on non-existent file" do
    assert {:fail, _message} = FileCache.get_file(2016,5)
  end

  test "should create cache dir if not already present", context do
    FileCache.save_file("dont","care","content")
    assert File.exists?(context[:dir])
  end
end
