defmodule EEWebArchive.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      EEWebArchiveWeb.Telemetry,
      # EEWebArchive.MainRepo,
      EEWebArchive.SmileyRepo,
      EEWebArchive.ArchivEERepo,
      {DNSCluster, query: Application.get_env(:ee_web_archive, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: EEWebArchive.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: EEWebArchive.Finch},
      # Start a worker by calling: EEWebArchive.Worker.start_link(arg)
      # {EEWebArchive.Worker, arg},
      # Start to serve requests, typically the last entry
      EEWebArchiveWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: EEWebArchive.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    EEWebArchiveWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
