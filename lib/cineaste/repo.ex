defmodule Cineaste.Repo do
  use Ecto.Repo,
    otp_app: :cineaste,
    adapter: Ecto.Adapters.Postgres
end
