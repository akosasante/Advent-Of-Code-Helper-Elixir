defmodule GetInputs do

  def get_value(year, day, session) do
    case FileCache.in_cache?(year,day) do
      true -> FileCache.get_file(year,day)
      false -> save_and_return(year,day,session)
    end
  end

  defp save_and_return(year,day,session) do
    {:ok, contents} = generate_url(year,day) |> get_from_url(session)
    FileCache.save_file(year,day,contents)
    {:ok, contents}
  end

  defp get_from_url(url, session) do
    response = HTTPotion.get(url, [headers: [cookie: "session=#{session}"]])
    case HTTPotion.Response.success?(response) do
      true -> {:ok, response.body}
      false -> {:fail, response.body}
    end
  end

  defp generate_url(year,day) do
    "http://adventofcode.com/#{year}/day/#{day}/input"
  end
end
