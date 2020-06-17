# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :chatbot,
  ecto_repos: [Chatbot.Repo]

# Configures the endpoint
config :chatbot, ChatbotWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "r6MEJYkT2SKwYJdMScpjVks3f8bCnA2IHhogoxqobYkJzghSH4X8xWqa93HW/6Fr",
  render_errors: [view: ChatbotWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Chatbot.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "MyYqaPPY"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Some Config
config :chatbot, :pow,
  user: Chatbot.Users.User,
  repo: Chatbot.Repo

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
