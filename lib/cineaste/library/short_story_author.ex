defmodule Cineaste.Library.ShortStoryAuthor do
  use Ash.Resource,
    otp_app: :cineaste,
    domain: Cineaste.Library,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "short_story_authors"
    repo Cineaste.Repo

    references do
      reference :short_story, on_delete: :delete
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
    belongs_to :short_story, Cineaste.Library.ShortStory, allow_nil?: false
    belongs_to :author, Cineaste.Library.Person, allow_nil?: false
  end

  identities do
    identity :unique_short_story_author, [:short_story_id, :author_id]
  end
end
