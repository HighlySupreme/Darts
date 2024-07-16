defmodule Darts.Router do
  use Plug.Router

  plug CORSPlug, origin: ["http://localhost:4200"]
  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Jason


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
    history = Darts.Game.get_history()
    send_resp(conn, 200, Jason.encode!(history))
  end

  get "/api/history/leaderboard" do
    leaderboard = Darts.Game.get_leaderboard()
    send_resp(conn, 200, Jason.encode!(leaderboard))
  end

  post "/api/submit_game" do
    %{"players" => players, "winner" => winner} = conn.body_params

    case Darts.Game.submit_game_result(players, winner) do
      {:ok, _} ->
        send_resp(conn, 200, Jason.encode!(%{message: "Game result submitted successfully"}))
      {:error, reason} ->
        send_resp(conn, 400, Jason.encode!(%{error: "Failed to submit game result: #{inspect(reason)}"}))
    end
  end

  match _ do
    send_resp(conn, 404, "Not found")
  end
end
