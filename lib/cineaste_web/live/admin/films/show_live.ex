defmodule CineasteWeb.Admin.Films.ShowLive do
  use CineasteWeb, :admin_live_view

  import CineasteWeb.CoreComponents

  def mount(%{"slug" => slug}, _session, socket) do
    film = Cineaste.Library.get_film_by_slug!(slug, load: [:aliases, :studios])
    {:ok, assign(socket, film: film)}
  end

  def render(assigns) do
    ~H"""
    <div>
      <h1>{@film.title}</h1>
      <a class="btn" href={~p"/dev/admin/films/#{@film.slug}/edit"}>
        <.icon name="tabler-pencil" /> Edit
      </a>
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
      <div :if={Enum.empty?(@film.aliases)}>
        <p>No aliases</p>
      </div>
      <%= for alias <- @film.aliases do %>
        <p>{alias.alias} ({alias.context})</p>
      <% end %>

      <h2>Studios</h2>
      <div :if={Enum.empty?(@film.studios)}>
        <p>No studios</p>
      </div>
      <%= for studio <- @film.studios do %>
        <p>{studio.display_name || studio.name}</p>
      <% end %>
    </div>
    """
  end
end
