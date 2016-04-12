defmodule PlugTest.PageController do
  use PlugTest.Web, :controller

  #plug :function_plug when action in [:test]

  def index(conn, _params) do
    render conn, "index.html"
  end

  def test(conn, _params) do
    text conn, "This is a test"
  end

  defp function_plug(conn, _options) do
    if Dict.has_key?(conn.params, "passkey") && conn.params["passkey"] == "ok" do
        conn
    else
        conn
        |> put_resp_content_type("text/plain")
        |> send_resp(500, "Error! need passkey")
    end
  end
end
