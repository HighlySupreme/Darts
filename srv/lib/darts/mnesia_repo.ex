defmodule Darts.MnesiaRepo do
  def init do
    :mnesia.create_schema([node()])
    :mnesia.start()
    :mnesia.create_table(:players, [attributes: [:id, :name, :games_played, :wins]])
    :mnesia.create_table(:game_history, [attributes: [:id, :players, :winner, :date]])
  end

  # Add functions for CRUD operations on players and game_history
end
