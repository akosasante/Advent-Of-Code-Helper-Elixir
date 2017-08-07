defmodule GetInputs do
  def get_value(year, day, session) do
    generate_url(year,day)
    |> get_from_url(session)
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
