defmodule CineasteWeb.Admin.People.ShowLive do
  use CineasteWeb, :admin_live_view

  def mount(%{"slug" => slug}, _session, socket) do
    person = Cineaste.Library.get_person_by_slug!(slug)
    {:ok, assign(socket, person: person)}
  end

  def render(assigns) do
    ~H"""
    """
  end
end
