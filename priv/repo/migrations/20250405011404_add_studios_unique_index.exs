defmodule Cineaste.Repo.Migrations.AddStudiosUniqueIndex do
  @moduledoc """
  Updates resources based on their most recent snapshots.

  This file was autogenerated with `mix ash_postgres.generate_migrations`
  """

  use Ecto.Migration

  def up do
    create unique_index(:studio_aliases, [:alias, :studio_id],
             name: "studio_aliases_unique_alias_per_studio_index"
           )
  end

  def down do
    drop_if_exists unique_index(:studio_aliases, [:alias, :studio_id],
                     name: "studio_aliases_unique_alias_per_studio_index"
                   )
  end
end
