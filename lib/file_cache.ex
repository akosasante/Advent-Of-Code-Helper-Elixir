defmodule FileCache do
  def save_file(year,day,content) do
    unless File.exists?(".cache/") do
      File.mkdir(".cache/")
    end
    write_out(".cache/input_#{year}_#{day}",content)
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
    filename = ".cache/input_#{year}_#{day}"
    case File.exists?(filename) do
      true -> {:ok, filename}
      false -> {:fail, filename}
    end
  end
end
