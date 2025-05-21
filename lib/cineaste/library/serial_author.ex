defmodule Cineaste.Library.SerialAuthor do
  use Ash.Resource,
    otp_app: :cineaste,
    domain: Cineaste.Library,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "serial_authors"
    repo Cineaste.Repo

    references do
      reference :serial, on_delete: :delete
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
    belongs_to :serial, Cineaste.Library.Serial, allow_nil?: false
    belongs_to :author, Cineaste.Library.Person, allow_nil?: false
  end

  identities do
    identity :unique_serial_author, [:serial_id, :author_id]
  end
end
