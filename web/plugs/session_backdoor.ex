defmodule Teamwork.Plug.SessionBackdoor do
  alias Teamwork.Repo
  alias Teamwork.User
  alias Teamwork.Parent
  import Doorman.Login.Session
  import Teamwork.ParentSession, only: [login_parent: 2]

  def init(default), do: default

  def call(conn, _default) do
    case conn.query_params do
      %{"as" => id} ->
        user = Repo.get!(User, id)
        conn
        |> login(user)
      %{"as_parent" => id} ->
        parent = Repo.get!(Parent, id)
        conn
        |> login_parent(parent)
      _ -> conn
    end
  end
end
