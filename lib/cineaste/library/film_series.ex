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
        :name,
        :slug
      ]

      argument :entries, {:array, :map}
      change manage_relationship(:entries, type: :direct_control, order_is_key: :order)
    end

    update :update do
      accept [
        :name,
        :slug
      ]

      require_atomic? false
      argument :entries, {:array, :map}
      change manage_relationship(:entries, type: :direct_control, order_is_key: :order)
    end
  end

  attributes do
    uuid_primary_key :id
    attribute :name, :string, allow_nil?: false
    attribute :slug, :string, allow_nil?: false

    create_timestamp :inserted_at
    update_timestamp :updated_at
  end

  relationships do
    has_many :entries, Cineaste.Library.FilmSeriesEntry, sort: [order: :asc]
  end

  identities do
    identity :unique_slug_per_film_series, [:slug]
  end
end
