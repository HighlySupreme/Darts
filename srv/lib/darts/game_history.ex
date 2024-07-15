defmodule Darts.GameHistory do
  use Ecto.Schema
  import Ecto.Changeset

  schema "game_history" do
    field :players, {:array, :string}
    field :winner, :string
    field :date, :utc_datetime

    timestamps()
  end

  def changeset(game_history, attrs) do
    game_history
    |> cast(attrs, [:players, :winner, :date])
    |> validate_required([:players, :winner, :date])
  end
end
