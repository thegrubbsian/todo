defmodule Repo do
  use Ecto.Repo, adapter: Ecto.Adapters.Postgres

  def conf do
    parse_url System.get_env("DATABASE_URL") ||
      "ecto://postgres:@localhost/elixir_todo_#{Mix.env}"
  end

  def priv do
    app_dir :todo, "priv/repo"
  end
end
