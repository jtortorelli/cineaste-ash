defmodule CineasteWeb.Admin.Films.IndexLive do
  use CineasteWeb, :live_view

  def mount(_params, _session, socket) do
    films = Cineaste.Library.read_films!(query: [sort_input: "sort_title"])
    {:ok, assign(socket, films: films)}
  end

  def render(assigns) do
    ~H"""
    <ul>
      <%= for film <- @films do %>
        <li><a href={~p"/dev/admin/films/#{film.slug}"}>{film.title}</a></li>
      <% end %>
    </ul>
    """
  end
end
