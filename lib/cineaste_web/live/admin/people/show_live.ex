defmodule CineasteWeb.Admin.People.ShowLive do
  use CineasteWeb, :admin_live_view

  def mount(%{"slug" => slug}, _session, socket) do
    person = Cineaste.Library.get_person_by_slug!(slug, load: [:aliases, relatives: [:relative]])
    {:ok, assign(socket, person: person)}
  end

  def render(assigns) do
    ~H"""
    <div>
      <h1>{@person.display_name}</h1>
      <a class="btn" href={~p"/dev/admin/people/#{@person.slug}/edit"}>
        <.icon name="tabler-pencil" /> Edit
      </a>
      <p>
        Showcased: <span :if={@person.showcased}><.icon name="tabler-circle-check-filled" /></span>
        <span :if={!@person.showcased}><.icon name="tabler-circle-x-filled" /></span>
      </p>
      <div>
        <img height="200" width="200" src={@person.avatar_url} />
      </div>
      <p>Japanese Name: {@person.japanese_name || "N/A"}</p>
      <p>Slug: <span class="font-mono">{@person.slug}</span></p>
      <p>Sort Name: {@person.sort_name}</p>
      <p>Disambiguation Characters: {@person.disambig_chars || "N/A"}</p>
      <p>Profession: {@person.profession || "N/A"}</p>
      <h2>Birth Details</h2>
      <p>Birth Date: {@person.dob || "N/A"}</p>
      <p>Birth Date Resolution: {@person.dob_resolution || "N/A"}</p>
      <p>Birth Place: {@person.birth_place || "N/A"}</p>
      <h2>Death Details</h2>
      <p>Death Date: {@person.dod || "N/A"}</p>
      <p>Death Date Resolution: {@person.dod_resolution || "N/A"}</p>
      <p>Death Place: {@person.death_place || "N/A"}</p>
      <p>Cause of Death: {@person.cause_of_death || "N/A"}</p>

      <h2>Aliases</h2>
      <div :if={Enum.empty?(@person.aliases)}>
        <p>No aliases</p>
      </div>
      <%= for alias <- @person.aliases do %>
        <p>
          {alias.alias} ({[alias.japanese_name, alias.category, alias.context]
          |> Enum.reject(&is_nil(&1))
          |> Enum.join(", ")})
        </p>
      <% end %>

      <h2>Relatives</h2>
      <div :if={Enum.empty?(@person.relatives)}>
        <p>No relatives</p>
      </div>
      <%= for relative <- @person.relatives do %>
        <p>{relative.relative.display_name} ({relative.relationship})</p>
      <% end %>
    </div>
    """
  end
end
