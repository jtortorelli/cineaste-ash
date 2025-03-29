defmodule CineasteWeb.Admin.FilmSeries.FormLive do
  use CineasteWeb, :admin_live_view

  def mount(%{"slug" => slug}, _session, socket) do
    film_series = Cineaste.Library.get_film_series_by_slug!(slug, load: [entries: [:film]])
    form = Cineaste.Library.form_to_update_film_series(film_series)

    films = Cineaste.Library.read_films!(query: [sort_input: "sort_title"])

    film_options =
      Enum.map(films, fn film ->
        {"#{film.title} (#{film.release_date.year})", film.id}
      end)

    socket =
      socket
      |> assign(:form, to_form(form))
      |> assign(:film_options, film_options)

    {:ok, socket}
  end

  def mount(_params, _session, socket) do
    form = Cineaste.Library.form_to_create_film_series()
    films = Cineaste.Library.read_films!(query: [sort_input: "sort_title"])

    film_options =
      Enum.map(films, fn film ->
        {"#{film.title} (#{film.release_date.year})", film.id}
      end)

    socket =
      socket
      |> assign(:form, to_form(form))
      |> assign(:film_options, film_options)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <.simple_form :let={form} for={@form} as={:form} phx-change="validate" phx-submit="save">
      <.input field={form[:name]} label="Name" />
      <.input field={form[:slug]} label="Slug" />
      <.entries_inputs form={form} film_options={@film_options} />
      <:actions>
        <button class="btn">Save</button>
      </:actions>
    </.simple_form>
    """
  end

  def entries_inputs(assigns) do
    ~H"""
    <h2>Entries</h2>
    <table class="table">
      <thead>
        <tr>
          <th>Film</th>
        </tr>
      </thead>
      <tbody phx-hook="Sortable" id="sortable">
        <.inputs_for :let={entry_form} field={@form[:entries]}>
          <tr data-id={entry_form.index}>
            <td>
              <.icon name="tabler-menu-2" class="handle cursor-pointer" />
            </td>
            <td>
              <.input field={entry_form[:film_id]} type="select" options={@film_options} />
            </td>
            <td>
              <a
                class="btn"
                phx-click="remove-entry"
                phx-value-path={entry_form.name}
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
    <a class="btn" phx-click="add-entry">Add Entry</a>
    """
  end

  def handle_event("add-entry", _params, socket) do
    socket = update(socket, :form, fn form -> AshPhoenix.Form.add_form(form, :entries) end)

    {:noreply, socket}
  end

  def handle_event("remove-entry", %{"path" => path}, socket) do
    socket = update(socket, :form, fn form -> AshPhoenix.Form.remove_form(form, path) end)

    {:noreply, socket}
  end

  def handle_event("reposition", %{"order" => order}, socket) do
    socket =
      update(socket, :form, fn form -> AshPhoenix.Form.sort_forms(form, [:entries], order) end)

    {:noreply, socket}
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
