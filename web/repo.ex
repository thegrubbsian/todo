defmodule Repo do
  use Ecto.Repo, adapter: Ecto.Adapters.Postgres

  def conf do
    parse_url "ecto://postgres:@localhost/elixir_todo"
  end

  def priv do
    app_dir :todo, "priv/repo"
  end
end
