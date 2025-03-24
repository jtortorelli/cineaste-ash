defmodule Cineaste.Library.FilmAlias do
  use Ash.Resource,
    otp_app: :cineaste,
    domain: Cineaste.Library,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "film_aliases"
    repo Cineaste.Repo

    references do
      reference :film, on_delete: :delete
    end
  end

  actions do
    defaults [:read, :destroy]

    create :create do
      primary? true
      accept [:alias, :context, :film_id]
    end

    update :update do
      primary? true
      accept [:alias, :context]
    end
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
