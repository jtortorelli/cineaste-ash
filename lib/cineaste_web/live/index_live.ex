defmodule CineasteWeb.IndexLive do
  use CineasteWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="hero bg-base-200 min-h-screen">
      <div class="hero-content text-center">
        <div class="max-w-md font-content ">
          <p class="py-6">
            Welcome to the Godzilla Cineaste, a fan-made guide to Japanese science fiction and fantasy film.
          </p>
          <p class="py-6">
            I hope you find this website useful as a repository of factoids and trivia about these beloved films and the people who made them. Or at least, I hope you find it an amusing distraction.
          </p>
          <p class="py-6">
            This website a labor of love and the selected films reflect the specific tastes and preferences of the author. All opinions are my own.
          </p>
          <p class="py-6">
            Get started by using the navigation links above. Happy reading!
          </p>
        </div>
      </div>
    </div>
    """
  end
end
