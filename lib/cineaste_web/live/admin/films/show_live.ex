defmodule CineasteWeb.Admin.Films.ShowLive do
  use CineasteWeb, :live_view

  import CineasteWeb.CoreComponents

  def mount(%{"slug" => slug}, _session, socket) do
    film = Cineaste.Library.get_film_by_slug!(slug, load: [:film_aliases])
    {:ok, assign(socket, film: film)}
  end

  def render(assigns) do
    ~H"""
    <div class="prose prose-headings:font-display prose-p:font-content">
      <h1>{@film.title}</h1>
      <.link navigate={~p"/dev/admin/films/#{@film.slug}/edit"}>
        <button class="btn">
          <.icon name="tabler-pencil" /> Edit
        </button>
      </.link>
      <p>
        Showcased:
        <span :if={@film.showcased}><.icon name="tabler-circle-check-filled" /></span><span :if={
          !@film.showcased
        }><.icon name="tabler-circle-x-filled" /></span>
      </p>
      <div><img src={@film.poster_url} /></div>
      <p>Slug: <span class="font-mono">{@film.slug}</span></p>
      <p>Release Date: {@film.release_date}</p>
      <p>Runtime: {@film.runtime} minutes</p>

      <h2>Original Title</h2>
      <p>Original: {@film.original_title}</p>
      <p>Translation: {@film.original_title_translation}</p>
      <p>Transliteration: {@film.original_title_transliteration}</p>

      <h2>Aliases</h2>
      <div :if={Enum.empty?(@film.film_aliases)}>
        <p>No aliases</p>
      </div>
      <%= for alias <- @film.film_aliases do %>
        <p>{alias.title} (alias.context)</p>
      <% end %>
    </div>
    """
  end
end
