defmodule Cineaste.Library.Person do
  use Ash.Resource,
    otp_app: :cineaste,
    domain: Cineaste.Library,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "people"
    repo Cineaste.Repo
  end

  actions do
    defaults [:read]

    read :search do
      argument :query, :ci_string do
        constraints allow_empty?: true
        default ""
      end

      pagination offset?: true, required?: false

      filter expr(
               contains(fragment("unaccent(display_name)"), ^arg(:query)) or
                 contains(japanese_name, ^arg(:query))
             )
    end

    create :create do
      accept [
        :slug,
        :display_name,
        :sort_name,
        :showcased,
        :disambig_chars,
        :profession,
        :avatar_url,
        :dob,
        :dob_resolution,
        :birth_place,
        :dod,
        :dod_resolution,
        :death_place,
        :cause_of_death,
        :japanese_name
      ]

      argument :aliases, {:array, :map}
      change manage_relationship(:aliases, type: :direct_control)
    end

    update :update do
      accept [
        :slug,
        :display_name,
        :sort_name,
        :showcased,
        :disambig_chars,
        :profession,
        :avatar_url,
        :dob,
        :dob_resolution,
        :birth_place,
        :dod,
        :dod_resolution,
        :death_place,
        :cause_of_death,
        :japanese_name
      ]

      require_atomic? false
      argument :aliases, {:array, :map}
      change manage_relationship(:aliases, type: :direct_control)
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :slug, :string, allow_nil?: false
    attribute :display_name, :string, allow_nil?: false
    attribute :sort_name, :string, public?: true
    attribute :showcased, :boolean, default: false
    attribute :disambig_chars, :string
    attribute :profession, :string
    attribute :avatar_url, :string
    attribute :dob, :date
    attribute :dob_resolution, :atom, constraints: [one_of: [:day, :month, :year, :unknown]]
    attribute :birth_place, :string
    attribute :dod, :date
    attribute :dod_resolution, :atom, constraints: [one_of: [:day, :month, :year, :unknown]]
    attribute :death_place, :string
    attribute :cause_of_death, :string
    attribute :japanese_name, :string

    create_timestamp :inserted_at
    update_timestamp :updated_at
  end

  relationships do
    has_many :aliases, Cineaste.Library.PersonAlias, sort: [alias: :asc]
  end

  identities do
    identity :unique_slug_per_person, [:slug]
  end
end
