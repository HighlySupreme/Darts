defmodule Darts.Player do
  use Ecto.Schema

  schema "players" do
    field :name, :string
    field :games_played, :integer, default: 0
    field :wins, :integer, default: 0
  end
end
