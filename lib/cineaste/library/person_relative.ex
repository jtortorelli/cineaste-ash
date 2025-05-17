defmodule Cineaste.Library.PersonRelative do
  use Ash.Resource,
    otp_app: :cineaste,
    domain: Cineaste.Library,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "person_relatives"
    repo Cineaste.Repo

    references do
      reference :self, on_delete: :delete
      reference :relative, on_delete: :delete
    end
  end

  actions do
    defaults [:read, :destroy]

    create :create do
      primary? true

      accept [
        :relationship,
        :order,
        :self_id,
        :relative_id
      ]
    end

    update :update do
      primary? true

      accept [
        :relationship,
        :order,
        :relative_id
      ]
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :relationship, Cineaste.Library.RelationshipType, allow_nil?: false
    attribute :order, :integer, allow_nil?: false

    create_timestamp :inserted_at
    update_timestamp :updated_at
  end

  relationships do
    belongs_to :self, Cineaste.Library.Person
    belongs_to :relative, Cineaste.Library.Person
  end

  identities do
    identity :unique_by_self_and_relative, [:self_id, :relative_id]
  end
end
