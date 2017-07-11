defmodule StockitServer.Mixfile do
  use Mix.Project

  def project do
    [app: :stockitServer,
     version: "0.0.1",
     elixir: "~> 1.4",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {StockitServer.Application, []},
     extra_applications: [:logger, :runtime_tools, :absinthe_plug, :amnesia,  :absinthe, :amnesia, :bamboo, :oauth2, :ueberauth, :ueberauth_github, :ueberauth_google, :ueberauth_facebook, :ueberauth_identity, :canary, :guardian]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:phoenix, "~> 1.3.0-rc", override: true},
     {:phoenix_pubsub, "~> 1.0"},
     {:phoenix_ecto, "~> 3.2"},
     {:postgrex, ">= 0.0.0"},
     {:phoenix_html, "~> 2.6"},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:gettext, "~> 0.11"},
     {:cowboy, "~> 1.0"},
     {:absinthe, "~> 1.3.1"},
     {:amnesia, "~> 0.2.5"},
     {:hasher, "~> 0.1.0"},
     {:absinthe_plug, "~> 1.3.0"},
     {:absinthe, "~> 1.3"},
     {:absinthe_ecto, "~> 0.1.0"},
     {:faker, "~> 0.7"},
     {:poison, "~> 2.0"},
     {:cors_plug, "~> 1.3"},
     {:ueberauth, "~> 0.4"},
     {:canary, "~> 1.1.1"},
     {:ueberauth_google, "~> 0.2"},
     {:ja_serializer, "~> 0.11.2"},
     {:ueberauth_facebook, "~> 0.6"},
     {:ueberauth_github, "~> 0.4"},
     {:ueberauth_identity, "~> 0.2"},
     {:ueberauth_google, "~> 0.2"},
     {:bamboo, "~> 0.7.0"},
     {:bamboo_smtp, "~> 1.2.1"},
     {:bodyguard, "~> 1.0.0"},
     {:secure_random, "~> 0.5.1"},
     {:oauth2, "~> 0.8.0"},
     {:guardian, "~> 0.14"}]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"],
     "test": ["ecto.create --quiet", "ecto.migrate", "test"]]
  end
end
