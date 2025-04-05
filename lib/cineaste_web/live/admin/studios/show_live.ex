defmodule CineasteWeb.Admin.Studios.ShowLive do
  use CineasteWeb, :admin_live_view

  def mount(%{"slug" => slug}, _session, socket) do
    studio = Cineaste.Library.get_studio_by_slug!(slug, load: [:aliases])
    {:ok, assign(socket, studio: studio)}
  end

  def render(assigns) do
    ~H"""
    <div>
      <h1>{@studio.display_name || @studio.name}</h1>
      <a class="btn" href={~p"/dev/admin/studios/#{@studio.slug}/edit"}>
        <.icon name="tabler-pencil" /> Edit
      </a>
    </div>
    <p>Name: {@studio.name}</p>
    <p>Display Name: {@studio.display_name || "N/A"}</p>
    <p>Slug: <span class="font-mono">{@studio.slug}</span></p>
    <p>Abbreviation: {@studio.abbreviation || "N/A"}</p>
    <p>Original Name: {@studio.original_name}</p>

    <h2>Aliases</h2>
    <div :if={Enum.empty?(@studio.aliases)}>
      <p>No aliases</p>
    </div>
    <%= for alias <- @studio.aliases do %>
      <p>{alias.alias}</p>
    <% end %>
    """
  end
end
