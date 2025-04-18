defmodule Cineaste.Repo.Migrations.AddFilmSeries do
  @moduledoc """
  Updates resources based on their most recent snapshots.

  This file was autogenerated with `mix ash_postgres.generate_migrations`
  """

  use Ecto.Migration

  def up do
    create table(:film_series_entries, primary_key: false) do
      add :id, :uuid, null: false, default: fragment("gen_random_uuid()"), primary_key: true
      add :entry_number, :bigint, null: false

      add :inserted_at, :utc_datetime_usec,
        null: false,
        default: fragment("(now() AT TIME ZONE 'utc')")

      add :updated_at, :utc_datetime_usec,
        null: false,
        default: fragment("(now() AT TIME ZONE 'utc')")

      add :film_id,
          references(:films,
            column: :id,
            name: "film_series_entries_film_id_fkey",
            type: :uuid,
            prefix: "public"
          ),
          null: false

      add :film_series_id, :uuid, null: false
    end

    create table(:film_series, primary_key: false) do
      add :id, :uuid, null: false, default: fragment("gen_random_uuid()"), primary_key: true
    end

    alter table(:film_series_entries) do
      modify :film_series_id,
             references(:film_series,
               column: :id,
               name: "film_series_entries_film_series_id_fkey",
               type: :uuid,
               prefix: "public"
             )
    end

    create unique_index(:film_series_entries, [:film_id, :film_series_id],
             name: "film_series_entries_unique_film_per_series_index"
           )

    alter table(:film_series) do
      add :slug, :text, null: false

      add :inserted_at, :utc_datetime_usec,
        null: false,
        default: fragment("(now() AT TIME ZONE 'utc')")

      add :updated_at, :utc_datetime_usec,
        null: false,
        default: fragment("(now() AT TIME ZONE 'utc')")
    end

    create unique_index(:film_series, [:slug],
             name: "film_series_unique_slug_per_film_series_index"
           )
  end

  def down do
    drop_if_exists unique_index(:film_series, [:slug],
                     name: "film_series_unique_slug_per_film_series_index"
                   )

    alter table(:film_series) do
      remove :updated_at
      remove :inserted_at
      remove :slug
    end

    drop_if_exists unique_index(:film_series_entries, [:film_id, :film_series_id],
                     name: "film_series_entries_unique_film_per_series_index"
                   )

    drop constraint(:film_series_entries, "film_series_entries_film_series_id_fkey")

    alter table(:film_series_entries) do
      modify :film_series_id, :uuid
    end

    drop table(:film_series)

    drop constraint(:film_series_entries, "film_series_entries_film_id_fkey")

    drop table(:film_series_entries)
  end
end
