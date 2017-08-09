defmodule FileCache do
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
  def save_file(year,day,content) do
    cache_dir = Application.get_env(:advent_of_code, :cache_dir)
    unless cache_dir |> File.exists? do
      File.mkdir(cache_dir)
    end
    write_out("input_#{year}_#{day}",content)
  end

  @doc """
  Wrapper for File.write to write into cache dir
  ## Parameters
    - File: String name of file to be written
    - Content: Data to be placed into file
  """
  defp write_out(file,content) do
    Path.join(Application.get_env(:advent_of_code, :cache_dir),file)
    |> File.write(content, [])
  end

  @doc """
  Gets file from cache, should we have it stored
  ## Parameters
    - Year: year of puzzle
    - Day: day of puzzle
  """
  def get_file(year,day) do
    case in_cache?(year,day) do
      true -> get_filename(year,day) |> File.read()
      false -> {:fail, "File not found for #{get_filename(year,day)}"}
    end
  end

  @doc """
  Checks to see if we have a puzzle input cached
  ## Parameters
    - year: year of puzzle
    - day: day of puzzle
  """
  def in_cache?(year,day) do
    get_filename(year,day)
    |> File.exists?
  end

  @doc """
  Generates filename from year & day of puzzle
  """
  defp get_filename(year,day) do
    Application.get_env(:advent_of_code, :cache_dir)
    |> Path.join("input_#{year}_#{day}")
  end
end
