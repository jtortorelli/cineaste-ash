defmodule CineasteWeb.Admin.FilmSeries.IndexLive do
  use CineasteWeb, :admin_live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(_params, _url, socket) do
    film_series = Cineaste.Library.read_film_series!(query: [sort_input: "name"])

    socket =
      socket
      |> assign(:film_series, film_series)

    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <a class="btn" href={~p"/dev/admin/film-series/new"}>
      <.icon name="tabler-plus" /> New Film Series
    </a>
    <ul>
      <%= for series <- @film_series do %>
        <li><a href={~p"/dev/admin/film-series/#{series.slug}"}>{series.name}</a></li>
      <% end %>
    </ul>
    """
  end
end
