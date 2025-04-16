defmodule Cineaste.Library.FilmStudio do
  use Ash.Resource,
    otp_app: :cineaste,
    domain: Cineaste.Library,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "film_studios"
    repo Cineaste.Repo
  end

  actions do
    defaults [:read, :destroy]

    create :create do
      primary? true
      accept [:film_id, :studio_id]
    end

    update :update do
      primary? true
      accept [:film_id, :studio_id]
    end
  end

  attributes do
  end

  relationships do
    belongs_to :film, Cineaste.Library.Film, primary_key?: true, allow_nil?: false
    belongs_to :studio, Cineaste.Library.Studio, primary_key?: true, allow_nil?: false
  end
end
