defmodule Todo.ItemsChannel do
  use Phoenix.Channel

  def join(socket, "public", _message) do
    { :ok, socket }
  end

  def event(socket, event, data) do
    broadcast_from(socket, event, data)
    socket
  end

end
