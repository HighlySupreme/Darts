defmodule Darts.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Darts.Repo,
      {Plug.Cowboy, scheme: :http, plug: Darts.Router, options: [port: 4000]}
    ]

    opts = [strategy: :one_for_one, name: Darts.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
