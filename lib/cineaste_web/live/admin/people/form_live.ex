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
    """
  end
end
