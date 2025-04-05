defmodule Cineaste.Library.Studio do
  use Ash.Resource,
    otp_app: :cineaste,
    domain: Cineaste.Library,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "studios"
    repo Cineaste.Repo
  end

  attributes do
    uuid_primary_key :id

    attribute :slug, :string, allow_nil?: false
    attribute :name, :string, allow_nil?: false
    attribute :original_name, :string
    attribute :abbreviation, :string
    attribute :display_name, :string

    create_timestamp :inserted_at
    update_timestamp :updated_at
  end

  relationships do
    has_many :aliases, Cineaste.Library.StudioAlias, sort: [alias: :asc]
  end

  identities do
    identity :unique_slug_per_studio, [:slug]
  end
end
