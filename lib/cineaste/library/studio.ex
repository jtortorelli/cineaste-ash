defmodule Cineaste.Library.Studio do
  use Ash.Resource,
    otp_app: :cineaste,
    domain: Cineaste.Library,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "studios"
    repo Cineaste.Repo
  end

  actions do
    defaults [:read]

    create :create do
      accept [
        :slug,
        :name,
        :original_name,
        :abbreviation,
        :display_name
      ]

      argument :aliases, {:array, :map}
      change manage_relationship(:aliases, type: :direct_control)
    end

    update :update do
      accept [
        :slug,
        :name,
        :original_name,
        :abbreviation,
        :display_name
      ]

      require_atomic? false
      argument :aliases, {:array, :map}
      change manage_relationship(:aliases, type: :direct_control)
    end

    read :search do
      argument :query, :ci_string do
        constraints allow_empty?: true
        default ""
      end

      filter expr(
               contains(name, ^arg(:query)) or contains(original_name, ^arg(:query)) or
                 contains(abbreviation, ^arg(:query))
             )
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :slug, :string, allow_nil?: false
    attribute :name, :string, allow_nil?: false, public?: true
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
