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

    read :search do
      argument :query, :ci_string do
        constraints allow_empty?: true
        default ""
      end

      filter expr(contains(fragment("unaccent(title)"), ^arg(:query)))
    end

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

      argument :aliases, {:array, :map}
      argument :film_studios, {:array, :map}
      change manage_relationship(:aliases, type: :direct_control)
      change manage_relationship(:film_studios, type: :direct_control)
    end

    update :update do
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

      require_atomic? false
      argument :aliases, {:array, :map}
      argument :film_studios, {:array, :map}
      change manage_relationship(:aliases, type: :direct_control)
      change manage_relationship(:film_studios, type: :direct_control)
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
    has_many :aliases, Cineaste.Library.FilmAlias, sort: [alias: :asc]
    has_many :film_series_entries, Cineaste.Library.FilmSeriesEntry
    has_many :film_studios, Cineaste.Library.FilmStudio

    many_to_many :studios, Cineaste.Library.Studio do
      through Cineaste.Library.FilmStudio
      source_attribute_on_join_resource :film_id
      destination_attribute_on_join_resource :studio_id
      sort name: :asc
    end
  end

  calculations do
    calculate :sort_title, :string, Cineaste.Library.Calculations.SortTitle, public?: true
  end

  identities do
    identity :unique_slug_per_film, [:slug]
  end
end
