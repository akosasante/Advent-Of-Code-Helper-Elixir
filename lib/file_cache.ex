defmodule AdventOfCodeHelper.FileCache do
  @moduledoc """
  Contains all the logic for reading/writing files on disk
  """

  @doc """
  Saves puzzle input to file for later usage
  ## Parameters
    - Year: Int year of puzzle
    - Day: Int day of puzzle
    - Content: Puzzle input
  """
  def save_file(year,day,content, file_mod \\ File) do
    cache_dir = Application.get_env(:advent_of_code_helper, :cache_dir)
    unless cache_dir |> file_mod.exists? do
      file_mod.mkdir(cache_dir)
    end
    write_out("input_#{year}_#{day}",content, file_mod)
  end

  defp write_out(file,content, file_mod) do
    Path.join(Application.get_env(:advent_of_code_helper, :cache_dir),file)
    |> file_mod.write(content, [])
  end

  @doc """
  Gets file from cache, should we have it stored
  ## Parameters
    - Year: year of puzzle
    - Day: day of puzzle
  """
  def get_file(year,day, file_mod \\ File) do
    case get_filename(year,day) |> file_mod.read() do
      {:ok, contents} -> {:ok, contents}
      {:error, _msg} -> {:fail, "No file found"}
    end
  end

  @doc """
  Checks to see if we have a puzzle input cached
  ## Parameters
    - year: year of puzzle
    - day: day of puzzle
  """
  def in_cache?(year,day, file_mod \\ File) do
    get_filename(year,day)
    |> File.exists?
  end

  defp get_filename(year,day) do
    Application.get_env(:advent_of_code_helper, :cache_dir)
    |> Path.join("input_#{year}_#{day}")
  end
end
