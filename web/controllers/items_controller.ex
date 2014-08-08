defmodule Todo.ItemsController do
  use Phoenix.Controller
  use Jazz
  import Ecto.Query

  def index(conn, _params) do
    items = Repo.all(from item in TodoItem, select: item)
    json conn, JSON.encode!(items)
  end

  def create(conn, params) do
    item = Repo.insert(%TodoItem{ title: params["title"], completed: params["completed"] })
    Phoenix.Topic.broadcast("todos", { "todo:created", item })
    json conn, JSON.encode!(item)
  end

  def update(conn, params) do
    item = Repo.get(TodoItem, params["id"])
    updated_item = %{ item | title: params["title"], completed: params["completed"] }
    Repo.update(updated_item)
    Phoenix.Topic.broadcast("todos", { "todo:updated", updated_item })
    json conn, JSON.encode!(updated_item)
  end

  def delete(conn, params) do
    item = Repo.get(TodoItem, params["id"])
    Repo.delete(item)
    Phoenix.Topic.broadcast("todos", { "todo:deleted", item })
    json conn, JSON.encode!(item)
  end

end
