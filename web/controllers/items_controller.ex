defmodule Todo.ItemsController do
  use Phoenix.Controller
  alias Phoenix.Topic
  import Ecto.Query
  use Jazz

  def index(conn, _params) do
    items = Repo.all(from item in TodoItem, select: item)
    json conn, JSON.encode!(items)
  end

  def create(conn, params) do
    item = Repo.insert(%TodoItem{
      title: params["title"],
      completed: params["completed"],
      order_index: params["order_index"]
    })
    Topic.broadcast("todos", { "todo:created", item, user_id(conn) })
    json conn, JSON.encode!(item)
  end

  def update(conn, params) do
    item = Repo.get(TodoItem, params["id"])
    updated_item = %{item | title: params["title"], completed: params["completed"]}
    Repo.update(updated_item)
    Topic.broadcast("todos", { "todo:updated", updated_item, user_id(conn) })
    json conn, JSON.encode!(updated_item)
  end

  def delete(conn, params) do
    item = Repo.get(TodoItem, params["id"])
    Repo.delete(item)
    Topic.broadcast("todos", { "todo:deleted", item, user_id(conn) })
    json conn, JSON.encode!(item)
  end

  def user_id(conn) do
    "#{Plug.Conn.get_req_header(conn, "userid")}"
  end

end
