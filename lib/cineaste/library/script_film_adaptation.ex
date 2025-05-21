defmodule Cineaste.Library.ScriptFilmAdaptation do
  use Ash.Resource,
    otp_app: :cineaste,
    domain: Cineaste.Library,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "script_film_adaptations"
    repo Cineaste.Repo

    references do
      reference :script, on_delete: :delete
      reference :film, on_delete: :delete
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
    belongs_to :film, Cineaste.Library.Film, allow_nil?: false
  end

  identities do
    identity :unique_adaptation, [:script_id, :film_id]
  end
end
