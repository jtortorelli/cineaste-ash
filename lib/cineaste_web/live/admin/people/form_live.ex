defmodule CineasteWeb.Admin.People.FormLive do
  use CineasteWeb, :admin_live_view

  def mount(%{"slug" => slug}, _session, socket) do
    person = Cineaste.Library.get_person_by_slug!(slug)
    form = Cineaste.Library.form_to_update_person(person)

    socket =
      socket
      |> assign(:form, to_form(form))

    {:ok, socket}
  end

  def mount(_params, _session, socket) do
    form = Cineaste.Library.form_to_create_person()

    socket = socket |> assign(:form, to_form(form))

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
      <:actions>
        <button class="btn">Save</button>
      </:actions>
    </.simple_form>
    """
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
end
