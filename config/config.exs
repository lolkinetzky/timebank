# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :timebank,
  ecto_repos: [Timebank.Repo]

# Configures the endpoint
config :timebank, TimebankWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "7qAq/5M0dFZSxg3jpfxqTGjeF81y5fG28NZ0m1wQsZFGe4AGwGAdE6qXnAxo2d9l",
  render_errors: [view: TimebankWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Timebank.PubSub,
  live_view: [signing_salt: "n/gATDi+"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
