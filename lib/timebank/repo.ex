defmodule Timebank.Repo do
  use Ecto.Repo,
    otp_app: :timebank,
    adapter: Ecto.Adapters.Postgres
end
