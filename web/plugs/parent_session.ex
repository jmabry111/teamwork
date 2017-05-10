defmodule Teamwork.ParentSession do
  import Plug.Conn
  alias Teamwork.Parent
  alias Teamwork.Endpoint
  alias Teamwork.Repo
  alias Phoenix.Token
  @twenty_four_hours 86400

  def init(default), do: default

  def call(conn, _default) do
    case get_session(conn, :current_parent) do
      nil ->
        conn
      id ->
        case Parent |> Repo.get(id) do
          nil ->
            conn
            |> delete_session(:current_parent)
          parent ->
            conn
            |> login_parent(parent)
        end
    end
  end

  def login_parent(conn, %Parent{}=parent) do
    parent =
      parent
      |> Repo.preload([:players], force: true)
    conn
    |> assign(:current_parent, parent)
    |> put_session(:current_parent, parent.id)
  end

  def login_parent(conn, id) do
    parent = Parent |> Repo.get(id)
    login_parent(conn, parent)
  end

  def generate_token(parent) do
    Endpoint
    |> Token.sign("parent", parent.id)
  end

  def verify_token(token) do
    Endpoint
    |> Token.verify("parent", token, max_age: @twenty_four_hours)
  end
end
