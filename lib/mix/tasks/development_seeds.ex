defmodule Mix.Tasks.DevelopmentSeeds do
  use Mix.Task
  import Teamwork.Factory
  alias Teamwork.Repo
  alias Teamwork.User

  @doc "insert dev data"
  def run(_args) do
    Mix.Task.run "ecto.migrate", []
    Mix.Task.run "app.start", []

    for table_name <- tables_to_truncate() do
      Ecto.Adapters.SQL.query!(Repo, "TRUNCATE TABLE #{table_name} CASCADE")
    end

    build(:user, email: "admin@example.com", password: "password")
    |> save
    |> print

  end


  defp tables_to_truncate do
    ~w(
       users
     )
  end

  defp print(%User{}=user) do
    IO.puts "User: #{user.email}/#{user.password}"
  end
end
