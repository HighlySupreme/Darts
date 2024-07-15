defmodule Darts.Player do
  use Ecto.Schema
  import Ecto.Changeset
  @derive {Jason.Encoder, only: [:id, :name, :games_played, :wins, :inserted_at, :updated_at]}

  alias Darts.Repo

  schema "players" do
    field :name, :string
    field :games_played, :integer, default: 0
    field :wins, :integer, default: 0

    timestamps()
  end

  def changeset(player, attrs) do
    player
    |> cast(attrs, [:name, :games_played, :wins])
    |> validate_required([:name])
  end

  def add_player(name) do
    # Create a changeset with the given name and default values for games_played and wins
    changeset = changeset(%Darts.Player{}, %{name: name, games_played: 0, wins: 0})

    # Insert the new player into the database
    case Repo.insert(changeset) do
      {:ok, _player} ->
        {:ok, "Player added successfully"}
      {:error, changeset} ->
        {:error, changeset}
    end
  end
end
