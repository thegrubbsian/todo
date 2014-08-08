defmodule Todo.ItemsChannel do
  use Phoenix.Channel

  def join(socket, "todo_items", identifier) do
    handler = spawn_link(fn -> messenger(socket, identifier) end)
    Phoenix.Topic.subscribe(handler, "todos")
    { :ok, socket }
  end

  def messenger(socket, identifier) do
    receive do
      { event, data } ->
        message = %{ identifier: identifier, data: data }
        IO.inspect message
        broadcast(socket, event, message)
      messenger(socket, identifier)
    end
  end

end
