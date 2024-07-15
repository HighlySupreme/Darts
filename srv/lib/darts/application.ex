defmodule Darts.Application do
  use Application

  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: Darts.Router, options: [port: 4000]},
      Darts.MnesiaRepo
    ]

    opts = [strategy: :one_for_one, name: Darts.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
