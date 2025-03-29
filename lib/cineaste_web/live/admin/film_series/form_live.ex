defmodule CineasteWeb.Admin.FilmSeries.FormLive do
  use CineasteWeb, :admin_live_view

  def mount(%{"slug" => slug}, _session, socket) do
    film_series = Cineaste.Library.get_film_series_by_slug!(slug)
    form = Cineaste.Library.form_to_update_film_series(film_series)

    {:ok, assign(socket, form: to_form(form))}
  end

  def mount(_params, _session, socket) do
    form = Cineaste.Library.form_to_create_film_series()
    {:ok, assign(socket, form: to_form(form))}
  end

  def render(assigns) do
    ~H"""
    <.simple_form :let={form} for={@form} as={:form} phx-change="validate" phx-submit="save">
      <.input field={form[:name]} label="Name" />
      <.input field={form[:slug]} label="Slug" />
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
      {:ok, _film_series} ->
        socket =
          socket
          |> put_flash(:info, "Film series saved successfully")
          |> push_navigate(to: ~p"/dev/admin/film-series/#{form_data["slug"]}")

        {:noreply, socket}

      {:error, form} ->
        socket = socket |> put_flash(:error, "Could not save film series") |> assign(:form, form)
        {:noreply, socket}
    end
  end
end
