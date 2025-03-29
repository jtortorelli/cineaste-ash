defmodule Cineaste.Library do
  use Ash.Domain, otp_app: :cineaste, extensions: [AshPhoenix]

  resources do
    resource Cineaste.Library.Film do
      define :read_films, action: :read
      define :search_films, action: :search, args: [:query]
      define :update_film, action: :update
      define :create_film, action: :create
      define :get_film_by_slug, action: :read, get_by: :slug
    end

    resource Cineaste.Library.FilmAlias

    resource Cineaste.Library.FilmSeries do
      define :read_film_series, action: :read
      define :get_film_series_by_slug, action: :read, get_by: :slug
      define :create_film_series, action: :create
      define :update_film_series, action: :update
    end

    resource Cineaste.Library.FilmSeriesEntry
  end
end
