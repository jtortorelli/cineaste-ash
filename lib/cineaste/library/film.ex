defmodule Cineaste.Library.Film do
  use Ash.Resource,
    otp_app: :cineaste,
    domain: Cineaste.Library,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "films"
    repo Cineaste.Repo
  end

  actions do
    defaults [:read]

    create :create do
      accept [:slug, :title, :release_date, :runtime, :showcased]
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :slug, :string, allow_nil?: false
    attribute :title, :string, allow_nil?: false
    attribute :release_date, :date, allow_nil?: false
    attribute :runtime, :integer
    attribute :showcased, :boolean, default: false

    create_timestamp :inserted_at
    update_timestamp :updated_at
  end

  calculations do
    calculate :sort_title, :string, Cineaste.Library.Calculations.SortTitle
  end

  identities do
    identity :unique_slug_per_film, [:slug]
  end
end
