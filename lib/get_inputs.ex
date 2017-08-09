defmodule GetInputs do

  def get_value(year, day, session) do
    if FileCache.in_cache?(year,day) do
      FileCache.get_file(year,day)
    end
    {:ok, contents} = generate_url(year,day) |> get_from_url(session)
    FileCache.save_file(year,day,contents)
    {:ok, contents}
  end

  def get_from_url(url, session) do
    response = HTTPotion.get(url, [headers: [cookie: "session=#{session}"]])
    case HTTPotion.Response.success?(response) do
      true -> {:ok, response.body}
      false -> {:fail, response.body}
    end
  end

  def generate_url(year,day) do
    "http://adventofcode.com/#{year}/day/#{day}/input"
  end
end
