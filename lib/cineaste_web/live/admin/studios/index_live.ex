defmodule CineasteWeb.Admin.Studios.IndexLive do
  use CineasteWeb, :admin_live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(params, _url, socket) do
    query_text = Map.get(params, "q", "")
    studios = Cineaste.Library.search_studios!(query_text, query: [sort_input: "name"])

    socket =
      socket
      |> assign(:query_text, query_text)
      |> assign(:studios, studios)

    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <a class="btn" href={~p"/dev/admin/studios/new"}>
        <.icon name="tabler-plus" /> New Studio
      </a>
    </div>
    <.search_box query={@query_text} method="get" data-role="studio-search" phx-submit="search" />
    <ul>
      <%= for studio <- @studios do %>
        <li>
          <a href={~p"/dev/admin/studios/#{studio.slug}"}>{studio.display_name || studio.name}</a>
        </li>
      <% end %>
    </ul>
    """
  end

  def handle_event("search", %{"query" => query}, socket) do
    params = remove_empty(%{q: query})
    {:noreply, push_patch(socket, to: ~p"/dev/admin/studios?#{params}")}
  end

  defp remove_empty(params) do
    Enum.filter(params, fn {_key, val} -> val != "" end)
  end
end
