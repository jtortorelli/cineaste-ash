defmodule CineasteWeb.Admin.Films.FormLive do
  use CineasteWeb, :admin_live_view

  def mount(%{"slug" => slug}, _session, socket) do
    film = Cineaste.Library.get_film_by_slug!(slug, load: [:aliases, :studios])
    form = Cineaste.Library.form_to_update_film(film)

    socket =
      socket
      |> assign(:form, to_form(form))
      |> assign(:studio_options, studio_options())

    {:ok, socket}
  end

  def mount(_params, _session, socket) do
    form = Cineaste.Library.form_to_create_film()

    socket =
      socket
      |> assign(:form, to_form(form))
      |> assign(:studio_options, studio_options())

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <.simple_form :let={form} for={@form} as={:form} phx-change="validate" phx-submit="save">
      <.input field={form[:title]} label="Title" />
      <.input field={form[:showcased]} label="Showcased" type="checkbox" />
      <.input field={form[:poster_url]} label="Poster URL" />
      <.input field={form[:slug]} label="Slug" />
      <.input field={form[:release_date]} label="Release Date" type="date" />
      <.input field={form[:runtime]} label="Runtime" type="number" />
      <.input field={form[:original_title]} label="Original Title" />
      <.input field={form[:original_title_translation]} label="Original Title Translation" />
      <.input field={form[:original_title_transliteration]} label="Original Title Transliteration" />
      <.alias_inputs form={form} />
      <.studio_inputs form={form} studio_options={@studio_options} />
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

  def studio_inputs(assigns) do
    ~H"""
    <h2>Studios</h2>
    <table class="table">
      <thead>
        <tr>
          <th>Studio</th>
        </tr>
      </thead>
      <tbody>
        <.inputs_for :let={studio_form} field={@form[:studios]}>
          <tr data-id={studio_form.index}>
            <td>
              <.live_select field={studio_form[:id]} options={@studio_options} />
            </td>
            <td>
              <a
                class="btn"
                phx-click="remove-studio"
                phx-value-path={studio_form.name}
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
    <a class="btn" phx-click="add-studio">Add Studio</a>
    """
  end

  def handle_event("add-alias", _params, socket) do
    socket = update(socket, :form, fn form -> AshPhoenix.Form.add_form(form, :aliases) end)

    {:noreply, socket}
  end

  def handle_event("remove-alias", %{"path" => path}, socket) do
    socket = update(socket, :form, fn form -> AshPhoenix.Form.remove_form(form, path) end)

    {:noreply, socket}
  end

  def handle_event("add-studio", _params, socket) do
    socket =
      update(socket, :form, fn form -> AshPhoenix.Form.add_form(form, :studios, type: :read) end)

    {:noreply, socket}
  end

  def handle_event("remove-studio", %{"path" => path}, socket) do
    socket = update(socket, :form, fn form -> AshPhoenix.Form.remove_form(form, path) end)

    {:noreply, socket}
  end

  def handle_event("validate", %{"form" => form_data}, socket) do
    socket = update(socket, :form, fn form -> AshPhoenix.Form.validate(form, form_data) end)
    {:noreply, socket}
  end

  def handle_event("save", %{"form" => form_data}, socket) do
    case AshPhoenix.Form.submit(socket.assigns.form, params: form_data) do
      {:ok, _film} ->
        socket =
          socket
          |> put_flash(:info, "Film saved successfully")
          |> push_navigate(to: ~p"/dev/admin/films/#{form_data["slug"]}")

        {:noreply, socket}

      {:error, form} ->
        socket = socket |> put_flash(:error, "Could not save film") |> assign(:form, form)

        {:noreply, socket}
    end
  end

  def handle_event("live_select_change", %{"text" => text, "id" => live_select_id}, socket) do
    send_update(LiveSelect.Component, id: live_select_id, options: studio_options(text))

    {:noreply, socket}
  end

  def studio_options(query_text \\ "") do
    studios = Cineaste.Library.search_studios!(query_text, query: [sort_input: "name"])

    Enum.map(studios, fn studio ->
      {"#{studio.display_name || studio.name}", studio.id}
    end)
  end
end
