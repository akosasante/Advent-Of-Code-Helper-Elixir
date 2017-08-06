defmodule GetInput do
  def getInput(day, session) do
    :ok
  end

  def makeRequest(url, session) do
    response = HTTPotion.get(url, [headers: [cookie: "session=" <> session ]])
    case HTTPotion.Response.success?(response) do
      true -> {:ok, response.body}
      false -> {:fail, response.body}
    end
  end
end
