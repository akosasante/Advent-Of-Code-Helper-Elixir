defmodule GetInput do
  def getInput(year, day, session) do
    getURL(year,day)
    |> makeRequest(session)
  end

  def makeRequest(url, session) do
    response = HTTPotion.get(url, [headers: [cookie: "session=#{session}"]])
    case HTTPotion.Response.success?(response) do
      true -> {:ok, response.body}
      false -> {:fail, response.body}
    end
  end

  def getURL(year,day) do
    "http://adventofcode.com/#{year}/day/#{day}/input"
  end
end
