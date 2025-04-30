defmodule CineasteWeb.Admin.People.IndexLive do
  use CineasteWeb, :admin_live_view

  @page_size 50

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(params, _url, socket) do
    query_text = Map.get(params, "q", "")

    people_page =
      Cineaste.Library.search_people!(query_text,
        page: [limit: @page_size, count: true],
        query: [sort_input: "sort_name"]
      )

    socket = socket |> assign(:people_page, people_page) |> assign(:query_text, query_text)

    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <a class="btn" href={~p"/dev/admin/people/new"}>
        <.icon name="tabler-plus" /> New Person
      </a>
    </div>
    <div>
      <.search_box query={@query_text} method="get" data-role="person-search" phx-submit="search" />
    </div>
    <div class="join grid grid-cols-2">
      <button class="join-item btn btn-outline" phx-click="previous_page">Previous page</button>
      <button class="join-item btn btn-outline" phx-click="next_page">Next</button>
    </div>
    <ul>
      <%= for person <- @people_page.results do %>
        <li>
          <a href={~p"/dev/admin/people/#{person.slug}"}>{person.display_name}</a>
        </li>
      <% end %>
    </ul>
    """
  end

  def handle_event("next_page", _params, socket) do
    socket = update(socket, :people_page, fn people_page -> Ash.page!(people_page, :next) end)

    {:noreply, socket}
  end

  def handle_event("previous_page", _params, socket) do
    socket = update(socket, :people_page, fn people_page -> Ash.page!(people_page, :prev) end)

    {:noreply, socket}
  end

  def handle_event("search", %{"query" => query}, socket) do
    params = remove_empty(%{q: query})
    {:noreply, push_patch(socket, to: ~p"/dev/admin/people?#{params}")}
  end

  defp remove_empty(params) do
    Enum.filter(params, fn {_key, val} -> val != "" end)
  end
end
