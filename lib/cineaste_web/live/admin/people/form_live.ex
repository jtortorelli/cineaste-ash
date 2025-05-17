defmodule CineasteWeb.Admin.People.FormLive do
  use CineasteWeb, :admin_live_view

  def mount(%{"slug" => slug}, _session, socket) do
    person = Cineaste.Library.get_person_by_slug!(slug, load: [:aliases, relatives: [:relative]])
    form = Cineaste.Library.form_to_update_person(person)

    socket =
      socket
      |> assign(:form, to_form(form))
      |> assign(:people_options, people_options())

    {:ok, socket}
  end

  def mount(_params, _session, socket) do
    form = Cineaste.Library.form_to_create_person()

    socket =
      socket
      |> assign(:form, to_form(form))
      |> assign(:people_options, people_options())

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <.simple_form :let={form} for={@form} as={:form} phx-change="validate" phx-submit="save">
      <.input field={form[:display_name]} label="Display Name" />
      <.input field={form[:showcased]} label="Showcased" type="checkbox" />
      <.input field={form[:avatar_url]} label="Avatar URL" />
      <.input field={form[:slug]} label="Slug" />
      <.input field={form[:japanese_name]} label="Japanese Name" />
      <.input field={form[:sort_name]} label="Sort Name" />
      <.input field={form[:disambig_chars]} label="Disambiguation Characters" />
      <.input field={form[:profession]} label="Profession" />
      <.input field={form[:dob]} label="Date of Birth" type="date" />
      <.input
        field={form[:dob_resolution]}
        label="Date of Birth Resolution"
        type="select"
        options={["day", "month", "year", "unknown"]}
      />
      <.input field={form[:birth_place]} label="Birth Place" />
      <.input field={form[:dod]} label="Date of Death" type="date" />
      <.input
        field={form[:dod_resolution]}
        label="Date of Death Resolution"
        type="select"
        options={["day", "monty", "year", "unknown"]}
      />
      <.input field={form[:death_place]} label="Death Place" />
      <.input field={form[:cause_of_death]} label="Cause of Death" />
      <.alias_inputs form={form} />
      <.relative_inputs form={form} people_options={@people_options} />
      <:actions>
        <button class="btn">Save</button>
      </:actions>
    </.simple_form>
    """
  end

  def alias_inputs(assigns) do
    ~H"""
    <h2>Aliases</h2>
    <table class="table">
      <thead>
        <tr>
          <th>Alias</th>
          <th>Japanese Name</th>
          <th>Categeory</th>
          <th>Context</th>
        </tr>
      </thead>
      <tbody>
        <.inputs_for :let={alias_form} field={@form[:aliases]}>
          <tr data-id={alias_form.index}>
            <td>
              <.input field={alias_form[:alias]} />
            </td>
            <td>
              <.input field={alias_form[:japanese_name]} />
            </td>
            <td>
              <.input
                field={alias_form[:category]}
                type="select"
                options={["birth_name", "alias", "mistranslation"]}
              />
            </td>
            <td>
              <.input field={alias_form[:context]} />
            </td>
            <td>
              <a
                class="btn"
                phx-click="remove-alias"
                phx-value-path={alias_form.name}
                kind="error"
                size="xs"
              >
                <.icon name="tabler-trash" />
              </a>
            </td>
          </tr>
        </.inputs_for>
      </tbody>
    </table>

    <a class="btn" phx-click="add-alias">
      Add Alias
    </a>
    """
  end

  def relative_inputs(assigns) do
    ~H"""
    <h2>Relatives</h2>
    <table class="table">
      <thead>
        <tr>
          <th></th>
          <th>Relative</th>
          <th>Relationship</th>
        </tr>
      </thead>
      <tbody phx-hook="Sortable" id="sortable">
        <.inputs_for :let={relative_form} field={@form[:relatives]}>
          <tr data-id={relative_form.index}>
            <td>
              <.icon name="tabler-menu-2" class="handle cursor-pointer" />
            </td>
            <td>
              <.live_select field={relative_form[:relative_id]} options={@people_options} />
            </td>
            <td>
              <.input
                field={relative_form[:relationship]}
                label="Relationship"
                type="select"
                options={relationship_type_options()}
              />
            </td>
            <td>
              <a
                class="btn"
                phx-click="remove-relative"
                phx-value-path={relative_form.name}
                kind="error"
                size="xs"
              >
                <.icon name="tabler-trash" />
              </a>
            </td>
          </tr>
        </.inputs_for>
      </tbody>
    </table>
    <a class="btn" phx-click="add-relative">Add Relative</a>
    """
  end

  def handle_event("add-relative", _params, socket) do
    socket = update(socket, :form, fn form -> AshPhoenix.Form.add_form(form, :relatives) end)
    {:noreply, socket}
  end

  def handle_event("remove-relative", %{"path" => path}, socket) do
    socket = update(socket, :form, fn form -> AshPhoenix.Form.remove_form(form, path) end)
    {:noreply, socket}
  end

  def handle_event("reposition", %{"order" => order}, socket) do
    socket =
      update(socket, :form, fn form -> AshPhoenix.Form.sort_forms(form, [:relatives], order) end)

    {:noreply, socket}
  end

  def handle_event("live_select_change", %{"text" => text, "id" => live_select_id}, socket) do
    send_update(LiveSelect.Component,
      id: live_select_id,
      options: people_options(query_text: text)
    )

    {:noreply, socket}
  end

  def handle_event("validate", %{"form" => form_data}, socket) do
    socket = update(socket, :form, fn form -> AshPhoenix.Form.validate(form, form_data) end)
    {:noreply, socket}
  end

  def handle_event("save", %{"form" => form_data}, socket) do
    case AshPhoenix.Form.submit(socket.assigns.form, params: form_data) do
      {:ok, _person} ->
        socket =
          socket
          |> put_flash(:info, "Person saved successfully")
          |> push_navigate(to: ~p"/dev/admin/people/#{form_data["slug"]}")

        {:noreply, socket}

      {:error, form} ->
        socket =
          socket
          |> put_flash(:error, "Could not save person")
          |> assign(:form, form)

        {:noreply, socket}
    end
  end

  def handle_event("add-alias", _params, socket) do
    socket = update(socket, :form, fn form -> AshPhoenix.Form.add_form(form, :aliases) end)

    {:noreply, socket}
  end

  def handle_event("remove-alias", %{"path" => path}, socket) do
    socket = update(socket, :form, fn form -> AshPhoenix.Form.remove_form(form, path) end)

    {:noreply, socket}
  end

  defp people_options(opts \\ []) do
    query_text = opts[:query_text] || ""

    people =
      Cineaste.Library.search_people!(query_text,
        page: [limit: 50],
        query: [sort_input: "sort_name"]
      )
      |> Map.get(:results)

    Enum.map(people, fn person -> {"#{person.display_name}", person.id} end)
  end

  defp relationship_type_options do
    Cineaste.Library.RelationshipType.values()
    |> Enum.map(fn value -> {Cineaste.Library.RelationshipType.label(value), value} end)
  end
end
