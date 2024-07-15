defmodule Darts.Game do
  alias Darts.{Repo, Player, GameHistory}

  def get_players do
    Repo.all(Player)
  end

  def get_history do
    Repo.all(GameHistory)
  end

  def get_leaderboard do
    Repo.all(Player)
    |> Enum.map(fn player ->
      %{
        name: player.name,
        games_played: player.games_played,
        games_won: player.wins,
        win_percentage: calculate_win_percentage(player.wins, player.games_played)
      }
    end)
  end

  defp calculate_win_percentage(wins, games_played) do
    case games_played do
      0 -> 0.0
      _ -> (wins / games_played) * 100
    end
  end
end
