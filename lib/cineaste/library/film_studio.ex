defmodule Cineaste.Library.FilmStudio do
  use Ash.Resource,
    otp_app: :cineaste,
    domain: Cineaste.Library,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "film_studios"
    repo Cineaste.Repo
  end

  attributes do
    uuid_primary_key :id

    create_timestamp :inserted_at
    update_timestamp :updated_at
  end

  relationships do
    belongs_to :film, Cineaste.Library.Film, allow_nil?: false
    belongs_to :studio, Cineaste.Library.Studio, allow_nil?: false
  end

  identities do
    identity :unique_studio_per_film, [:film_id, :studio_id]
  end
end
