defmodule FileCache do
  def save_file(year,day,content) do
    cache_dir = Application.get_env(:advent_of_code, :cache_dir)
    unless cache_dir |> File.exists? do
      File.mkdir(cache_dir)
    end
    write_out(Path.join(cache_dir,"input_#{year}_#{day}"),content)
  end

  defp write_out(file,content) do
    File.write(file,content, [])
  end

  def get_file(year,day) do
    case in_cache?(year,day) do
      true -> get_filename(year,day) |> File.read()
      false -> {:fail, "File not found for #{get_filename(year,day)}"}
    end
  end

  def in_cache?(year,day) do
    get_filename(year,day)
    |> File.exists?
  end

  defp get_filename(year,day) do
    Application.get_env(:advent_of_code, :cache_dir)
    |> Path.join("input_#{year}_#{day}")
  end
end
