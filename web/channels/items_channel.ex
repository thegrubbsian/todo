defmodule Todo.ItemsChannel do
  use Phoenix.Channel

  def join(socket, "todo_items", _message) do
    handler = spawn_link(fn -> messenger(socket) end)
    Phoenix.Topic.subscribe(handler, "todos")
    { :ok, socket }
  end

  def messenger(socket) do
    receive do
      { event, data } ->
        IO.puts "broadcasting: #{event}, #{data}"
        broadcast(socket, event, data)
      messenger(socket)
    end
  end

end
