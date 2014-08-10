defmodule Todo.ItemsChannel do
  use Phoenix.Channel
  alias Phoenix.Topic
  alias Phoenix.Socket

  def join(socket, "public", data) do
    socket = Socket.assign(socket, :user_id, data["user_id"])
    handler = spawn_link(fn -> publisher(socket) end)
    Topic.subscribe(handler, "todo-events")
    { :ok, socket }
  end

  def publisher(socket) do
    receive do
      { event, data, user_id } ->
        socket_user_id = Socket.get_assign(socket, :user_id)
        if "#{socket_user_id}" == "#{user_id}" do
          broadcast_from(socket, event, data)
        end
      publisher(socket)
    end
  end

end
