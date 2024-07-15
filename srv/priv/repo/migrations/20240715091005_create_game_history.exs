defmodule Darts.Repo.Migrations.CreateGameHistory do
  use Ecto.Migration

  def change do
    create table(:game_history) do
      add :players, {:array, :string}
      add :winner, :string
      add :date, :utc_datetime

      timestamps()
    end
  end
end
