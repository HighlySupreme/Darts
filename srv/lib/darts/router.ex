defmodule Darts.Router do
  use Plug.Router

  plug :match
  plug :dispatch
  plug CORSPlug

  get "/api/players" do
    # Implement fetching all players
  end

  get "/api/history" do
    # Implement fetching game history
  end

  get "/api/history/leaderboard" do
    # Implement fetching leaderboard data
  end

  post "/api/history/clear" do
    # Implement clearing specific history entry
  end

  match _ do
    send_resp(conn, 404, "Not found")
  end
end
