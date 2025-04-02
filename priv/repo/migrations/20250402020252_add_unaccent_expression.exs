defmodule Cineaste.Repo.Migrations.AddUnaccentExpression do
  use Ecto.Migration

  def change do
    execute(
      "CREATE EXTENSION IF NOT EXISTS unaccent;",
      "DROP EXTENSION IF EXISTS unaccent;"
    )
  end
end
