defmodule Cineaste.Library.StudioAlias do
  use Ash.Resource,
    otp_app: :cineaste,
    domain: Cineaste.Library,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "studio_aliases"
    repo Cineaste.Repo
  end

  actions do
    defaults [:read, :destroy]

    create :create do
      primary? true

      accept [
        :alias,
        :studio_id
      ]
    end

    update :update do
      primary? true
      accept [:alias]
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :alias, :string, allow_nil?: false

    create_timestamp :inserted_at
    update_timestamp :updated_at
  end

  relationships do
    belongs_to :studio, Cineaste.Library.Studio, allow_nil?: false
  end

  identities do
    identity :unique_alias_per_studio, [:alias, :studio_id]
  end
end
