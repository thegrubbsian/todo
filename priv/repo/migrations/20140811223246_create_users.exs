defmodule Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def up do
    "CREATE TABLE IF NOT EXISTS users
      (
        id serial primary key,
        socket_token text,
        name text
      )"
  end

  def down do
    "DROP TABLE IF EXISTS users"
  end
end
