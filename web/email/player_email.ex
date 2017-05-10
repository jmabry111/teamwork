defmodule Teamwork.PlayerEmail do
  use Bamboo.Phoenix, view: Teamwork.EmailView

  def tokenized_email(parent, token) do
    base_email()
    |> to(parent.email)
    |> subject("Register another player")
    |> put_layout({Teamwork.LayoutView, :email})
    |> render(:tokenized_link, parent: parent, token: token)
  end

  def base_email do
    new_email()
    |> from("noreply@example.com")
  end
end
