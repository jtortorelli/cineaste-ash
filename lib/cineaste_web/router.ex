defmodule CineasteWeb.Router do
  use CineasteWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {CineasteWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CineasteWeb do
    pipe_through :browser

    live "/", IndexLive
    live "/about", AboutLive
    live "/films", Films.IndexLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", CineasteWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:cineaste, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live "/admin/films", CineasteWeb.Admin.Films.IndexLive
      live "/admin/films/new", CineasteWeb.Admin.Films.FormLive
      live "/admin/films/:slug", CineasteWeb.Admin.Films.ShowLive
      live "/admin/films/:slug/edit", CineasteWeb.Admin.Films.FormLive

      live "/admin/film-series", CineasteWeb.Admin.FilmSeries.IndexLive
      live "/admin/film-series/new", CineasteWeb.Admin.FilmSeries.FormLive
      live "/admin/film-series/:slug", CineasteWeb.Admin.FilmSeries.ShowLive
      live "/admin/film-series/:slug/edit", CineasteWeb.Admin.FilmSeries.FormLive

      live_dashboard "/dashboard", metrics: CineasteWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
