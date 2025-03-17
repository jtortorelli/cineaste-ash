defmodule Cineaste.Library.FilmAlias do
  use Ash.Resource,
    otp_app: :cineaste,
    domain: Cineaste.Library,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "film_aliases"
    repo Cineaste.Repo
  end

  actions do
    defaults [:read]
  end

  attributes do
    uuid_primary_key :id

    attribute :alias, :string, allow_nil?: false
    attribute :context, :string, allow_nil?: false

    create_timestamp :inserted_at
    update_timestamp :updated_at
  end

  relationships do
    belongs_to :film, Cineaste.Library.Film, allow_nil?: false
  end
end
