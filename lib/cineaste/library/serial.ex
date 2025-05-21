defmodule Cineaste.Library.Serial do
  use Ash.Resource,
    otp_app: :cineaste,
    domain: Cineaste.Library,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "serials"
    repo Cineaste.Repo
  end

  attributes do
    uuid_primary_key :id

    attribute :slug, :string, allow_nil?: false
    attribute :title, :string, allow_nil?: false

    create_timestamp :inserted_at
    update_timestamp :updated_at
  end

  identities do
    identity :unique_slug_per_serial, [:slug]
  end
end
