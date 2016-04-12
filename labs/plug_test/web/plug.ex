defmodule PlugTest.Plug do
  import Plug.Conn
  
  def init(options) do
    options
  end

  def call(conn, _options) do
    if Dict.has_key?(conn.params, "passkey") && conn.params["passkey"] == "ok" do
        conn
    else
        conn
        |> put_resp_content_type("text/plain")
        |> send_resp(500, "Error! need passkey")
    end
  end
end