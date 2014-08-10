defmodule TodoItem do
  use Ecto.Model

  schema "todo_items" do
    field :title
    field :completed, :boolean
    field :order_index, :integer
  end

end
