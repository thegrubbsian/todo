defmodule MyPlug do
  import Plug.Conn
  use Plug.Router

  plug :match
  plug :dispatch

  get "/hello/:name" do
    send_resp(conn, 200, "Hello, #{name}")
  end

  match _ do
    send_resp(conn, 404, "Oops...")
  end

end

IO.puts "Running MyPlug with Cowboy on http://localhost:4000"
Plug.Adapters.Cowboy.http MyPlug, []
