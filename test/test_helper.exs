Application.ensure_all_started(:hound)
PhantomJS.start
ExUnit.start
Ecto.Adapters.SQL.Sandbox.mode(Teamwork.Repo, :manual)

