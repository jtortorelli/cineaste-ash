defmodule Cineaste.Library.PersonAlias do
  use Ash.Resource,
    otp_app: :cineaste,
    domain: Cineaste.Library,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "person_aliases"
    repo Cineaste.Repo

    references do
      reference :person, on_delete: :delete
    end
  end

  actions do
    defaults [:read, :destroy]

    create :create do
      primary? true
      accept [:alias, :japanese_name, :category, :context, :person_id]
    end

    update :update do
      primary? true
      accept [:alias, :japanese_name, :category, :context]
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :alias, :string, allow_nil?: false
    attribute :japanese_name, :string
    attribute :category, :atom, constraints: [one_of: [:birth_name, :alias, :mistranslation]]
    attribute :context, :string

    create_timestamp :inserted_at
    update_timestamp :updated_at
  end

  relationships do
    belongs_to :person, Cineaste.Library.Person, allow_nil?: false
  end
end
