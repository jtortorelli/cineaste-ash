defmodule Cineaste.Library.Calculations.SortTitle do
  use Ash.Resource.Calculation

  def calculate(films, _opts, _context) do
    films
    |> Enum.map(fn %{title: title} ->
      title
      |> String.downcase()
      |> String.replace(~r/^(the)\s+/, "")
    end)
  end

  def expression(_opts, _context) do
    expr(fragment("lower(regexp_replace(title, '^The ', ''))"))
  end
end
