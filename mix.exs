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
      applications: [:poolboy, :phoenix, :ranch, :postgrex, :decimal, :ecto]
    ]
  end

  defp deps do
    [
      {:poolboy, "~> 1.2.1"},
      {:decimal, "~> 0.2.4"},
      {:postgrex, "~> 0.5.4"},
      {:ecto, "~> 0.2.3"},
      {:cowboy, "~> 1.0.0", github: "extend/cowboy", override: true},
      {:ranch, "~> 1.0.0", github: "ninenines/ranch", ref: "1.0.0"},
      {:phoenix, github: "phoenixframework/phoenix"}
    ]
  end
end
