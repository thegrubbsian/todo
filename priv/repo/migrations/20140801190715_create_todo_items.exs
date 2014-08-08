defmodule Repo.Migrations.CreateTodoItems do
  use Ecto.Migration

  def up do
    "CREATE TABLE IF NOT EXISTS todo_items (id serial primary key, title text, completed boolean, owner text)"
  end

  def down do
    "DROP TABLE IF EXISTS todo_items"
  end
end
