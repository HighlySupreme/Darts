import Config

config :darts, Darts.Repo,
  database: "darts.sqlite3",
  pool_size: 5

config :darts,
  ecto_repos: [Darts.Repo]
