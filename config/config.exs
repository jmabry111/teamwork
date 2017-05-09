# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :teamwork,
  ecto_repos: [Teamwork.Repo]

# Configures the endpoint
config :teamwork, Teamwork.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "mhn9GfU/VD+8wTExAGsK2yiORhVO2O/vEBYDJ0G6JgGXeIjXeJwmaG/0M+YqGA1V",
  render_errors: [view: Teamwork.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Teamwork.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

config :formulator, translate_error_module: Teamwork.ErrorHelpers

config :doorman,
  repo: Teamwork.Repo,
  secure_with: Doorman.Auth.Bcrypt,
  user_module: Teamwork.User
