defmodule Todo.Router do
  use Phoenix.Router
  use Phoenix.Router.Socket, mount: "/ws"

  plug Plug.Static, at: "/static", from: :todo

  get "/", Todo.PagesController, :index, as: :page

  get "/todos", Todo.ItemsController, :index
  post "/todos", Todo.ItemsController, :create
  put "/todos/:id", Todo.ItemsController, :update
  delete "/todos/:id", Todo.ItemsController, :delete

  channel "todo_items", Todo.ItemsChannel
end
