defmodule Teamwork.Plug.SessionBackdoor do
  alias Teamwork.Repo
  alias Teamwork.User
  import Doorman.Login.Session

  def init(default), do: default

  def call(conn, _default) do
    case conn.query_params do
      %{"as" => id} ->
        user = Repo.get!(User, id)
        conn
        |> login(user)
      _ -> conn
    end
  end
end
