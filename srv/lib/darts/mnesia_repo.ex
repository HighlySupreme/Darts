defmodule Darts.MnesiaRepo do
  def init do
    :mnesia.start()
  end

  def get_players do
    {:atomic, players} = :mnesia.transaction(fn ->
      :mnesia.match_object({:players, :_, :_, :_, :_})
    end)
    IO.inspect(players)
    players |> Enum.map(&player_to_map/1)
  end

  def get_history do
    {:atomic, history} = :mnesia.transaction(fn ->
      :mnesia.match_object({:game_history, :_, :_, :_, :_})
    end)
    history |> Enum.map(&history_to_map/1)
  end

  def get_leaderboard do
    players = get_players()
    Enum.map(players, fn player ->
      %{
        name: player.name,
        games_played: player.games_played,
        games_won: player.wins,
        win_percentage: calculate_win_percentage(player.wins, player.games_played)
      }
    end)
  end

  defp player_to_map({:players, id, name, games_played, wins}) do
    %{id: id, name: name, games_played: games_played, wins: wins}
  end

  defp history_to_map({:game_history, id, players, winner, date}) do
    %{id: id, players: players, winner: winner, date: date}
  end

  defp calculate_win_percentage(wins, games_played) do
    case games_played do
      0 -> 0.0
      _ -> (wins / games_played) * 100
    end
  end
end
