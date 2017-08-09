defmodule FileCache do
  def save_file(year,day,content) do
    cache_dir = Application.get_env(:advent_of_code, :cache_dir)
    unless File.exists?(cache_dir) do
      File.mkdir(cache_dir)
    end
    write_out(Path.join(cache_dir,"input_#{year}_#{day}"),content)
  end

  defp write_out(file,content) do
    File.write(file,content, [])
  end

  def get_file(year,day) do
    case in_cache?(year,day) do
      {:ok, filename} -> File.read(filename)
      {:fail, filename} -> {:fail, "File not found for #{filename}"}
    end
  end

  def in_cache?(year,day) do
    filename = Application.get_env(:advent_of_code, :cache_dir)
               |> Path.join("input_#{year}_#{day}")
    case File.exists?(filename) do
      true -> {:ok, filename}
      false -> {:fail, filename}
    end
  end
end
