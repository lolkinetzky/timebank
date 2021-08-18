defmodule Timebank.Application do
  use Application

  def start(_type, _args) do
    children = [
      Timebank.Repo,
      TimebankWeb.Telemetry,
      {Phoenix.PubSub, name: Timebank.PubSub},
      TimebankWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: Timebank.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    TimebankWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
