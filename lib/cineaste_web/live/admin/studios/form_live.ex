defmodule CineasteWeb.Admin.Studios.FormLive do
  use CineasteWeb, :admin_live_view

  def mount(%{"slug" => slug}, _session, socket) do
    studio = Cineaste.Library.get_studio_by_slug!(slug, load: [:aliases])
    form = Cineaste.Library.form_to_update_studio(studio)
    {:ok, assign(socket, form: to_form(form))}
  end

  def mount(_params, _session, socket) do
    form = Cineaste.Library.form_to_create_studio()
    {:ok, assign(socket, form: to_form(form))}
  end

  def render(assigns) do
    ~H"""
    <.simple_form :let={form} for={@form} as={:form} phx-change="validate" phx-submit="save">
      <.input field={form[:slug]} label="Slug" />
      <.input field={form[:name]} label="Name" />
      <.input field={form[:original_name]} label="Original Name" />
      <.input field={form[:abbreviation]} label="Abbreviation" />
      <.input field={form[:display_name]} label="Display Name" />
      <.alias_inputs form={form} />
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
        </tr>
      </thead>
      <tbody>
        <.inputs_for :let={alias_form} field={@form[:aliases]}>
          <tr data-id={alias_form.index}>
            <td>
              <.input field={alias_form[:alias]} />
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

  def handle_event("add-alias", _params, socket) do
    socket = update(socket, :form, fn form -> AshPhoenix.Form.add_form(form, :aliases) end)

    {:noreply, socket}
  end

  def handle_event("remove-alias", %{"path" => path}, socket) do
    socket = update(socket, :form, fn form -> AshPhoenix.Form.remove_form(form, path) end)

    {:noreply, socket}
  end

  def handle_event("validate", %{"form" => form_data}, socket) do
    socket = update(socket, :form, fn form -> AshPhoenix.Form.validate(form, form_data) end)
    {:noreply, socket}
  end

  def handle_event("save", %{"form" => form_data}, socket) do
    case AshPhoenix.Form.submit(socket.assigns.form, params: form_data) do
      {:ok, _studio} ->
        socket =
          socket
          |> put_flash(:info, "Studio saved successfully")
          |> push_navigate(to: ~p"/dev/admin/studios/#{form_data["slug"]}")

        {:noreply, socket}

      {:error, form} ->
        socket = socket |> put_flash(:error, "Could not save studio") |> assign(:form, form)

        {:noreply, socket}
    end
  end
end
