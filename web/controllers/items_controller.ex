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
    item_json = JSON.enclde!(item)
    Phoenix.Topic.broadcast("todos", { "todo:created", item_json })
    json conn, item_json
  end

  def update(conn, params) do
    item = Repo.get(TodoItem, params["id"])
    updated_item = %{item | title: params["title"], completed: params["completed"]}
    Repo.update(updated_item)
    item_json = JSON.encode!(updated_item)
    Phoenix.Topic.broadcast("todos", { "todo:updated", item_json })
    json conn, item_json
  end

  def delete(conn, params) do
    item = Repo.get(TodoItem, params["id"])
    Repo.delete(item)
    item_json = JSON.encode!(item)
    Phoenix.Topic.broadcast("todos", { "todo:deleted", item_json })
    json conn, item_json
  end

end
