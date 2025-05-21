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

    resource Cineaste.Library.Studio do
      define :search_studios, action: :search, args: [:query]
      define :get_studio_by_slug, action: :read, get_by: :slug
      define :create_studio, action: :create
      define :update_studio, action: :update
    end

    resource Cineaste.Library.StudioAlias
    resource Cineaste.Library.FilmStudio

    resource Cineaste.Library.Person do
      define :read_people, action: :read
      define :search_people, action: :search, args: [:query]
      define :update_person, action: :update
      define :create_person, action: :create
      define :get_person_by_slug, action: :read, get_by: :slug
    end

    resource Cineaste.Library.PersonAlias
    resource Cineaste.Library.PersonRelative
    resource Cineaste.Library.TVSeries
    resource Cineaste.Library.Book
    resource Cineaste.Library.BookSeries
    resource Cineaste.Library.Serial
    resource Cineaste.Library.Script
    resource Cineaste.Library.ShortStory
    resource Cineaste.Library.BookAuthor
    resource Cineaste.Library.BookSeriesAuthor
    resource Cineaste.Library.SerialAuthor
    resource Cineaste.Library.ScriptAuthor
    resource Cineaste.Library.ShortStoryAuthor
    resource Cineaste.Library.TVSeriesFilmAdaptation
    resource Cineaste.Library.BookFilmAdaptation
    resource Cineaste.Library.BookSeriesFilmAdaptation
    resource Cineaste.Library.SerialFilmAdaptation
    resource Cineaste.Library.ScriptFilmAdaptation
    resource Cineaste.Library.ShortStoryFilmAdaptation
  end
end
