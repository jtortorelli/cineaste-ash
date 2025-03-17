defmodule CineasteWeb.Admin.Films.FormLive do
  use CineasteWeb, :live_view

  def mount(%{"slug" => slug}, _session, socket) do
    film = Cineaste.Library.get_film_by_slug!(slug)
    form = Cineaste.Library.form_to_update_film(film)

    {:ok, assign(socket, form: to_form(form))}
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
end
