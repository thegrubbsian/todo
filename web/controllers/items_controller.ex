defmodule Todo.ItemsController do
  use Phoenix.Controller
  use Jazz
  import Ecto.Query

  def index(conn, _params) do
    items = Repo.all(from item in TodoItem, select: item)
    json conn, JSON.encode!(items)
  end

  def create(conn, params) do
    item = Repo.insert(%TodoItem{ guid: params["guid"],
      title: params["title"], completed: params["completed"] })
    broadcast("todo:created", item)
    json conn, JSON.encode!(item)
  end

  def update(conn, params) do
    item = Repo.get(TodoItem, params["id"])
    updated_item = %{item | title: params["title"], completed: params["completed"]}
    Repo.update(updated_item)
    broadcast("todo:updated", updated_item)
    json conn, JSON.encode!(updated_item)
  end

  def delete(conn, params) do
    item = Repo.get(TodoItem, params["id"])
    Repo.delete(item)
    broadcast("todo:deleted", item)
    json conn, JSON.encode!(item)
  end

  def broadcast(event, data) do
    Phoenix.Topic.broadcast("todos", { event, JSON.encode!(data) })
  end

end
