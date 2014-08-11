defmodule Todo.ItemsChannel do
  use Phoenix.Channel
  alias Phoenix.Topic
  alias Phoenix.Socket

  def join(socket, "public", data) do
    handler = spawn_link(fn -> publisher(socket, data["user_id"]) end)
    Topic.subscribe(handler, "todos")
    { :ok, socket }
  end

  def publisher(socket, user_id) do
    receive do
      { event, data, ^user_id } ->
        broadcast_from(socket, event, data)
      publisher(socket, user_id)
    end
  end

end
