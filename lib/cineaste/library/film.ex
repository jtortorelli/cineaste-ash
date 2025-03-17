defmodule Cineaste.Library.Film do
  use Ash.Resource,
    otp_app: :cineaste,
    domain: Cineaste.Library,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "films"
    repo Cineaste.Repo
  end

  actions do
    defaults [:read]

    create :create do
      accept [
        :original_title,
        :original_title_transliteration,
        :original_title_translation,
        :poster_url,
        :slug,
        :title,
        :release_date,
        :runtime,
        :showcased
      ]
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :original_title, :string
    attribute :original_title_translation, :string
    attribute :original_title_transliteration, :string
    attribute :poster_url, :string
    attribute :slug, :string, allow_nil?: false
    attribute :title, :string, allow_nil?: false
    attribute :release_date, :date, allow_nil?: false
    attribute :runtime, :integer
    attribute :showcased, :boolean, default: false

    create_timestamp :inserted_at
    update_timestamp :updated_at
  end

  relationships do
    has_many :film_aliases, Cineaste.Library.FilmAlias
  end

  calculations do
    calculate :sort_title, :string, Cineaste.Library.Calculations.SortTitle, public?: true
  end

  identities do
    identity :unique_slug_per_film, [:slug]
  end
end
