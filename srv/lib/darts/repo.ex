defmodule Darts.Repo do
  use Ecto.Repo,
    otp_app: :darts,
    adapter: Ecto.Adapters.SQLite3
end
