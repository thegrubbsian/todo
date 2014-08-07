defmodule Todo.Mixfile do
  use Mix.Project

  def project do
    [ app: :todo,
      version: "0.0.1",
      elixir: "~> 0.15.0",
      elixirc_paths: ["lib", "web"],
      deps: deps ]
  end

  def application do
    [
      mod: { Todo, [] },
      applications: [:poolboy, :ranch, :phoenix, :postgrex, :decimal, :ecto]
    ]
  end

  defp deps do
    [
      {:postgrex, "~> 0.5.4"},
      {:ecto, "~> 0.2.3"},
      {:jsex, "~> 2.0.0"},
      {:cowboy, "~> 1.0.0"},
      {:phoenix, github: "phoenixframework/phoenix"}
    ]
  end
end
