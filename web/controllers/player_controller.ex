defmodule Teamwork.PlayerController do
  use Teamwork.Web, :controller
  alias Teamwork.Player
  import Teamwork.PlayerQuery

  def new(conn, %{"parent_id" => _parent_id}) do
    changeset = Player.changeset(%Player{})

    conn
    |> assign(:changeset, changeset)
    |> assign(:parent, conn.assigns[:current_parent])
    |> render(:new)
  end

  def create(conn, %{"parent_id" => _parent_id, "player" => player_params}) do
    params = Map.merge(player_params, %{"parent_id" => conn.assigns[:current_parent].id})
    changeset = Player.changeset(%Player{}, params)

    case Repo.insert(changeset) do
      {:ok, player} ->
        conn
        |> put_flash(:info, gettext("Thanks for registering."))
        |> redirect(to: parent_path(conn, :show, player.parent_id))
      {:error, changeset} ->
        conn
        |> assign(:changeset, changeset)
        |> assign(:parent, conn.assigns[:current_parent])
        |> render(:new)
    end
  end

  def show(conn, %{"id" => id}) do
    player = find_player(id, conn.assigns[:current_parent].id)

    conn
    |> assign(:player, player)
    |> render(:show)
  end
end
