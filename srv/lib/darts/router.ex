defmodule Darts.Router do
  use Plug.Router

  plug CORSPlug, origin: ["http://localhost:4200"]

  plug :match
  plug :dispatch
  plug Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Jason

  get "/api/players" do
    players = Darts.Game.get_players()
    send_resp(conn, 200, Jason.encode!(players))
  end

  get "/api/history" do
    history = Darts.Game.get_histroy()
    send_resp(conn, 200, Jason.encode!(history))
  end

  get "/api/history/leaderboard" do
    leaderboard = Darts.Game.get_leaderboard()
    send_resp(conn, 200, Jason.encode!(leaderboard))
  end

  match _ do
    send_resp(conn, 404, "Not found")
  end
end
