defmodule Todo.ItemsController do
  use Phoenix.Controller
  import Ecto.Query

  def index(conn, _params) do
    items = Repo.all(from item in TodoItem, select: item)
    { :ok, items_json } = JSEX.encode(items)
    IO.puts("AFTER JSEX CALL")
    json conn, items_json
  end

  def create(conn, params) do
    item = Repo.insert(%TodoItem{ guid: params["guid"],
      title: params["title"], completed: params["completed"] })
    item_json = to_json(item)
    Phoenix.Topic.broadcast("todos", { "todo:created", item_json })
    json conn, item_json
  end

  def update(conn, params) do
    item = Repo.get(TodoItem, params["id"])
    updated_item = %{item | title: params["title"], completed: params["completed"]}
    Repo.update(updated_item)
    item_json = to_json(updated_item)
    Phoenix.Topic.broadcast("todos", { "todo:updated", item_json })
    json conn, item_json
  end

  def delete(conn, params) do
    item = Repo.get(TodoItem, params["id"])
    Repo.delete(item)
    item_json = to_json(item)
    Phoenix.Topic.broadcast("todos", { "todo:deleted", item_json })
    json conn, item_json
  end

  defp to_json(item) do
    { :ok, json } = JSEX.encode(item)
    json
  end

end
