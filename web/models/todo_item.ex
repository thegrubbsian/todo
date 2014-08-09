defmodule TodoItem do
  use Ecto.Model

  schema "todo_items" do
    field :title
    field :completed, :boolean
  end

end
