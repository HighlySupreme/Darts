defmodule Darts.Game do
  alias Darts.{Repo, Player, GameHistory}
  import Ecto.Query, only: [from: 2]

  def get_players do
    from(p in Player, select: p.name)
  |> Repo.all()
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

  def submit_game_result(players, winner) do
    # Start a transaction
    Repo.transaction(fn ->
      # Create a new game history entry
      {:ok, _history} = %GameHistory{}
      |> GameHistory.changeset(%{
        players: players,
        winner: winner,
        date: DateTime.utc_now()
      })
      |> Repo.insert()

      # Update player statistics
      Enum.each(players, fn player_name ->
        player = Repo.get_by(Player, name: player_name)

        player_params = %{
          name: player_name,
          games_played: (if player, do: player.games_played + 1, else: 1),
          wins: (if player_name == winner, do: (if player, do: player.wins + 1, else: 1), else: (if player, do: player.wins, else: 0))
        }

        if player do
          player
          |> Player.changeset(player_params)
          |> Repo.update()
        else
          # If the player doesn't exist, create a new one
          %Player{}
          |> Player.changeset(player_params)
          |> Repo.insert()
        end
      end)
    end)
  end
end
