defmodule CineasteWeb.Admin.People.IndexLive do
  use CineasteWeb, :admin_live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(_params, _url, socket) do
    people = Cineaste.Library.read_people!()

    socket = socket |> assign(:people, people)

    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    """
  end
end
