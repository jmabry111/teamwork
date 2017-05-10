defmodule Teamwork.ParentController do
  use Teamwork.Web, :controller
  alias Teamwork.ParentSession
  alias Teamwork.Parent
  alias Teamwork.TokenizedEmail

  def show(conn, %{"id" => _id}) do
    parent = conn.assigns[:current_parent]
    conn
    |> assign(:players, parent.players)
    |> assign(:parent, parent)
    |> render(:show)
  end

  def new(conn, _params) do
    changeset = Parent.changeset(%Parent{})

    conn
    |> assign(:changeset, changeset)
    |> render(:new)
  end

  def create(conn, %{"parent" => parent_params}) do
    changeset = Parent.changeset(%Parent{}, parent_params)
    case Repo.insert(changeset) do
      {:ok, parent} ->
        conn
        |> ParentSession.login_parent(parent)
        |> put_flash(:info, gettext("Great! Now let's add a player!"))
        |> redirect(to: parent_player_path(conn, :new, parent))
      {:error, changeset} ->
        if email_taken?(changeset) do
          TokenizedEmail.send_tokenized_email(changeset.changes[:email])
          conn
          |> put_flash(:error, gettext("Hey! Looks like you've been here before. Please check your email for a link to add more players."))
          |> redirect(to: "/")
        else
          conn
          |> assign(:changeset, changeset)
          |> render(:new)
        end
    end
  end

  def email_taken?(changeset) do
    {:email, {"has already been taken", []}} in changeset.errors
  end
end
