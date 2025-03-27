defmodule CineasteWeb.Admin.Films.IndexLive do
  use CineasteWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(params, _url, socket) do
    query_text = Map.get(params, "q", "")
    films = Cineaste.Library.search_films!(query_text, query: [sort_input: "sort_title"])

    socket =
      socket
      |> assign(:query_text, query_text)
      |> assign(:films, films)

    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <.search_box query={@query_text} method="get" data-role="film-search" phx-submit="search" />
    <ul>
      <%= for film <- @films do %>
        <li><a href={~p"/dev/admin/films/#{film.slug}"}>{film.title}</a></li>
      <% end %>
    </ul>
    """
  end

  attr :query, :string, default: ""
  attr :rest, :global, include: ~w(method action phx-submit data-role)
  slot :inner_block, required: false

  def search_box(assigns) do
    ~H"""
    <form class="relative w-fit inline-block" {@rest}>
      <.icon name="tabler-search" class="w-4 h-4 m-2 ml-3 absolute bg-base-content/50" />
      <label for="search-text" class="hidden">Search</label>
      <input
        class="input input-bordered rounded-full input-sm pl-8 w-32 sm:w-48"
        name="query"
        id="search-text"
        placeholder="search films by name"
        value={@query}
      />
      {render_slot(@inner_block)}
    </form>
    """
  end

  def handle_event("search", %{"query" => query}, socket) do
    params = remove_empty(%{q: query})
    {:noreply, push_patch(socket, to: ~p"/dev/admin/films?#{params}")}
  end

  defp remove_empty(params) do
    Enum.filter(params, fn {_key, val} -> val != "" end)
  end
end
