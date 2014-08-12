defmodule Todo.PagesController do
  use Phoenix.Controller

  def index(conn, _params) do
    render conn, "index"
  end

  def todo_list(conn, _params) do
    render conn, "todos"
  end
end
