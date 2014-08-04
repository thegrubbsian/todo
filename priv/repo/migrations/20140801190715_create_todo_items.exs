defmodule Repo.Migrations.CreateTodoItems do
  use Ecto.Migration

  def up do
    "CREATE TABLE IF NOT EXISTS todo_items (id serial primary key, guid text unique, title text, completed boolean)"
  end

  def down do
    "DROP TABLE IF EXISTS todo_items"
  end
end
