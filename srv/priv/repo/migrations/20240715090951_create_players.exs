defmodule Darts.Repo.Migrations.CreatePlayers do
  use Ecto.Migration

  def change do
    create table(:players) do
      add :name, :string
      add :games_played, :integer, default: 0
      add :wins, :integer, default: 0

      timestamps()
    end
  end
end
