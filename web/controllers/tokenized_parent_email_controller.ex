defmodule Teamwork.TokenizedParentEmailController do
  use Teamwork.Web, :controller
  alias Teamwork.TokenizedEmail

  def create(conn, %{"parent" => %{"email" => email}}) do
    TokenizedEmail.send_tokenized_email(email)

    conn
    |> put_flash(:info, "Email sent!")
    |> redirect(to: "/")
  end
end
