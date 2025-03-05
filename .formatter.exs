[
  import_deps: [:ash_postgres, :ash, :ecto, :ecto_sql, :phoenix],
  subdirectories: ["priv/*/migrations", "priv/*/seeds"],
  plugins: [Spark.Formatter, Phoenix.LiveView.HTMLFormatter],
  inputs: [
    "*.{heex,ex,exs}",
    "{config,lib,test}/**/*.{heex,ex,exs}",
    "priv/*/seeds.exs",
    "priv/*/seeds/*.exs"
  ]
]
