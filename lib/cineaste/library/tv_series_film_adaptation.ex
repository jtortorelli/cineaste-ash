defmodule Cineaste.Library.TVSeriesFilmAdaptation do
  use Ash.Resource,
    otp_app: :cineaste,
    domain: Cineaste.Library,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "tv_series_film_adaptations"
    repo Cineaste.Repo

    references do
      reference :tv_series, on_delete: :delete
      reference :film, on_delete: :delete
    end
  end

  actions do
    defaults [:read, :destroy]
  end

  attributes do
    uuid_primary_key :id

    create_timestamp :inserted_at
    update_timestamp :updated_at
  end

  relationships do
    belongs_to :tv_series, Cineaste.Library.TVSeries, allow_nil?: false
    belongs_to :film, Cineaste.Library.Film, allow_nil?: false
  end

  identities do
    identity :unique_adaptation, [:tv_series_id, :film_id]
  end
end
