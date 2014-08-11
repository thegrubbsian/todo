defmodule Todo.ItemsChannel do
  use Phoenix.Channel
  import Phoenix.Socket
  alias Phoenix.Topic
  alias Phoenix.Socket

  def join(socket, "public", data) do
    socket = Socket.assign(socket, :user_id, data["user_id"])
    handler = spawn_link(fn -> publisher(socket) end)
    Topic.subscribe(handler, "todos")
    { :ok, socket }
  end

  def publisher(socket) do
    user_id = "#{Socket.get_assign(socket, :user_id)}"
    receive do
      { event, data, ^user_id } ->
        broadcast_from(socket, event, data)
      publisher(socket)
    end
  end

end
