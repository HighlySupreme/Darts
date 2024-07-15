defmodule Darts.GameHistory do
  use Ecto.Schema

  schema "game_history" do
    field :players, {:array, :string}
    field :winner, :string
    field :date, :utc_datetime
  end
end
