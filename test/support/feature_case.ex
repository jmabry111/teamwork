defmodule Teamwork.FeatureCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Hound.Helpers

      import Ecto.Schema, except: [build: 2]
      import Ecto.Query, only: [from: 2]
      import Teamwork.Router.Helpers
      import Teamwork.FeatureHelpers
      import Teamwork.RoleHelpers
      import Teamwork.AuthHelpers
      import Teamwork.Factory

      alias Teamwork.Repo

      @endpoint Teamwork.Endpoint
    end
  end

  setup tags do
    on_exit fn ->
      PhantomJS.clear_local_storage
    end

    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Teamwork.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Teamwork.Repo, {:shared, self()})
    end

    Hound.start_session
    :ok
  end
end
