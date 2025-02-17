defmodule Darts.MixProject do
  use Mix.Project

  def project do
    [
      app: :darts,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :mnesia],
      mod: {Darts.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.5"},
      {:jason, "~> 1.2"},
      {:cors_plug, "~> 3.0"},
      {:ecto_sql, "~> 3.6"},
      {:ecto_sqlite3, "~> 0.8.0"}
    ]
  end
end
