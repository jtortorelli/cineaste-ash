defmodule Cineaste.Library.BookSeriesAuthor do
  use Ash.Resource,
    otp_app: :cineaste,
    domain: Cineaste.Library,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "book_series_authors"
    repo Cineaste.Repo

    references do
      reference :book_series, on_delete: :delete
      reference :author, on_delete: :delete
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
    belongs_to :book_series, Cineaste.Library.BookSeries, allow_nil?: false
    belongs_to :author, Cineaste.Library.Person, allow_nil?: false
  end

  identities do
    identity :unique_book_series_author, [:book_series_id, :author_id]
  end
end
