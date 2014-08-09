defmodule Todo.ItemsController do
  use Phoenix.Controller
  alias Phoenix.Channel
  import Ecto.Query
  use Jazz

  def index(conn, _params) do
    items = Repo.all(from item in TodoItem, select: item)
    json conn, JSON.encode!(items)
  end

  def create(conn, params) do
    item = Repo.insert(%TodoItem{ title: params["title"], completed: params["completed"] })
    Channel.broadcast("todos", "public", "todo:created", item)
    json conn, JSON.encode!(item)
  end

  def update(conn, params) do
    item = Repo.get(TodoItem, params["id"])
    updated_item = %{item | title: params["title"], completed: params["completed"]}
    Repo.update(updated_item)
    Channel.broadcast("todos", "public", "todo:updated", updated_item)
    json conn, JSON.encode!(updated_item)
  end

  def delete(conn, params) do
    item = Repo.get(TodoItem, params["id"])
    Repo.delete(item)
    Channel.broadcast("todos", "public", "todo:deleted", item)
    json conn, JSON.encode!(item)
  end

end
