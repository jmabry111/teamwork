defmodule Teamwork.TokenVerifier do
  import Phoenix.Controller
  alias Teamwork.ParentSession

  def init(default), do: default

  def call(%{params: %{"token" => token}} = conn, _default) do
    case ParentSession.verify_token(token) do
      {:ok, parent_id} ->
        conn
        |> ParentSession.login_parent(parent_id)
      _ ->
        conn
        |> put_flash(:error, "We're very sorry but we could not locate your token")
        |> redirect(to: "/")
        |> Plug.Conn.halt
    end
  end

  def call(conn, _), do: conn
end
