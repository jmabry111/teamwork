defmodule Teamwork.RequireParent do
  import Plug.Conn
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]

  def init(default), do: default

  def call(conn, _default) do
    if conn.assigns[:current_parent] == nil do
      conn
      |> put_session(:redirect_path, conn.request_path)
      |> put_flash(:error, "You must be logged in as a parent to visit this page")
      |> redirect(to: "/parents/new")
      |> halt
    else
      conn
    end
  end
end
