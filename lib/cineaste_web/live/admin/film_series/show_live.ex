defmodule CineasteWeb.Admin.FilmSeries.ShowLive do
  use CineasteWeb, :admin_live_view

  def mount(%{"slug" => slug}, _session, socket) do
    film_series = Cineaste.Library.get_film_series_by_slug!(slug, load: [entries: :film])

    {:ok, assign(socket, film_series: film_series)}
  end

  def render(assigns) do
    ~H"""
    <div>
      <h1>{@film_series.name}</h1>
      <a class="btn" href={~p"/dev/admin/film-series/#{@film_series.slug}/edit"}>
        <.icon name="tabler-pencil" /> Edit
      </a>
      <p>Slug: <span class="font-mono">{@film_series.slug}</span></p>

      <h2>Films</h2>
      <div :if={Enum.empty?(@film_series.entries)}>
        <p>No films in this series</p>
      </div>
      <%= for entry <- @film_series.entries do %>
        <p><a href={~p"/dev/admin/films/#{entry.film.slug}"}>{entry.film.title}</a></p>
      <% end %>
    </div>
    """
  end
end
