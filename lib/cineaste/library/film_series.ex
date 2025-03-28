defmodule Cineaste.Library.FilmSeries do
  use Ash.Resource,
    otp_app: :cineaste,
    domain: Cineaste.Library,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "film_series"
    repo Cineaste.Repo
  end

  actions do
    defaults [:read]

    create :create do
      accept [
        :slug
      ]

      argument :entries, {:array, :map}
      change manage_relationship(:entries, type: :direct_control, order_is_key: :entry_number)
    end

    update :update do
      accept [
        :slug
      ]
      require_atomic? false
      argument :entries, {:array, :map}
      change manage_relationship(:entries, type: :direct_control, order_is_key: :entry_number)
    end
  end

  attributes do
    uuid_primary_key :id
    attribute :slug, :string, allow_nil?: false

    create_timestamp :inserted_at
    update_timestamp :updated_at
  end

  relationships do
    has_many :entries, Cineaste.Library.FilmSeriesEntry, sort: [entry_number: :asc]
  end

  identities do
    identity :unique_slug_per_film_series, [:slug]
  end
end
