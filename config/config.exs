# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :stockitServer,
  ecto_repos: [StockitServer.Repo]

# Configures the endpoint
config :stockitServer, StockitServer.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Fcfmz2CVX5PD+8vtxWUFYDCqH8dT+It3Hk+kq6ZjCPevJ7xBs6yxgPXgT/Fp8wAQ",
  render_errors: [view: StockitServer.Web.ErrorView, accepts: ~w(json)],
  pubsub: [name: StockitServer.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

 config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "StockitServer",
  ttl: { 30, :days },
  allowed_drift: 2000,
  verify_issuer: true, # optional
  secret_key: System.get_env("GUARDIAN_SECRET"),
  serializer: StockitServer.Web.GuardianSerializer

  config :stockitServer, StockitServer.Mailer,
  adapter: Swoosh.Adapters.SMTP,
  relay: "smtp.gmail.com",
  username: System.get_env("GMAIL_TEST_USERNAME"),
  password: System.get_env("GMAIL_TEST_PASSWORD"),
  tls: :always,
  auth: :always

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
