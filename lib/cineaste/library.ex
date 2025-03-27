defmodule Cineaste.Library do
  use Ash.Domain, otp_app: :cineaste, extensions: [AshPhoenix]

  resources do
    resource Cineaste.Library.Film do
      define :read_films, action: :read
      define :search_films, action: :search, args: [:query]
      define :update_film, action: :update
      define :get_film_by_slug, action: :read, get_by: :slug
    end

    resource Cineaste.Library.FilmAlias
  end
end
