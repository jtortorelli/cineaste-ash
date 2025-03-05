defmodule Cineaste.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CineasteWeb.Telemetry,
      Cineaste.Repo,
      {DNSCluster, query: Application.get_env(:cineaste, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Cineaste.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Cineaste.Finch},
      # Start a worker by calling: Cineaste.Worker.start_link(arg)
      # {Cineaste.Worker, arg},
      # Start to serve requests, typically the last entry
      CineasteWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Cineaste.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CineasteWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
