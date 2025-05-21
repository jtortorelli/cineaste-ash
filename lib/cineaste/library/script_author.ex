defmodule Cineaste.Library.ScriptAuthor do
  use Ash.Resource,
    otp_app: :cineaste,
    domain: Cineaste.Library,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "script_authors"
    repo Cineaste.Repo

    references do
      reference :script, on_delete: :delete
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
    belongs_to :script, Cineaste.Library.Script, allow_nil?: false
    belongs_to :author, Cineaste.Library.Person, allow_nil?: false
  end

  identities do
    identity :unique_script_author, [:script_id, :author_id]
  end
end
