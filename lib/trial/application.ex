defmodule Trial.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TrialWeb.Telemetry,
      Trial.Repo,
      {DNSCluster, query: Application.get_env(:trial, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Trial.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Trial.Finch},
      # Start a worker by calling: Trial.Worker.start_link(arg)
      # {Trial.Worker, arg},
      # Start to serve requests, typically the last entry
      TrialWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Trial.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TrialWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
