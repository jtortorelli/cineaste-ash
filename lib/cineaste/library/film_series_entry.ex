defmodule Cineaste.Library.FilmSeriesEntry do
  use Ash.Resource,
    otp_app: :cineaste,
    domain: Cineaste.Library,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "film_series_entries"
    repo Cineaste.Repo
  end

  actions do
    defaults [:read, :destroy]

    create :create do
      primary? true
      accept [
        :entry_number,
        :film_id,
        :film_series_id
      ]
    end

    update :update do
      primary? true
      accept [:entry_number]
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :entry_number, :integer, allow_nil?: false

    create_timestamp :inserted_at
    update_timestamp :updated_at
  end

  relationships do
    belongs_to :film, Cineaste.Library.Film, allow_nil?: false
    belongs_to :film_series, Cineaste.Library.FilmSeries, allow_nil?: false
  end

  identities do
    identity :unique_film_per_series, [:film_id, :film_series_id]
  end
end
