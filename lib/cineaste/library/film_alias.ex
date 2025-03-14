defmodule Cineaste.Library.FilmAlias do
  use Ash.Resource,
    data_layer: :embedded

  attributes do
    attribute :title, :string, allow_nil?: false
    attribute :context, :string, allow_nil?: false
  end
end
