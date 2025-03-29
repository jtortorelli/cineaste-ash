defmodule Cineaste.Library.FilmSeriesEntry do
  use Ash.Resource,
    otp_app: :cineaste,
    domain: Cineaste.Library,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "film_series_entries"
    repo Cineaste.Repo

    references do
      reference :film_series, on_delete: :delete
      reference :film, on_delete: :delete
    end
  end

  actions do
    defaults [:read, :destroy]

    create :create do
      primary? true

      accept [
        :order,
        :film_id,
        :film_series_id
      ]
    end

    update :update do
      primary? true
      accept [:order]
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :order, :integer, allow_nil?: false

    create_timestamp :inserted_at
    update_timestamp :updated_at
  end

  relationships do
    belongs_to :film, Cineaste.Library.Film, allow_nil?: false
    belongs_to :film_series, Cineaste.Library.FilmSeries, allow_nil?: false
  end

  calculations do
    calculate :number, :integer, expr(order + 1)
  end

  identities do
    identity :unique_film_per_series, [:film_id, :film_series_id]
  end
end
