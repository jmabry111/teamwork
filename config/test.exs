use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :teamwork, Teamwork.Endpoint,
  http: [port: 4001],
  server: true

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :teamwork, Teamwork.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "teamwork_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :hound, driver: "phantomjs", port: 8910

#config :teamwork, Teamwork.Mailer, adapter: Bamboo.TestAdapter
