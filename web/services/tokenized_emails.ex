defmodule Teamwork.TokenizedEmail do
  alias Teamwork.Parent
  alias Teamwork.ParentSession
  alias Teamwork.Repo
  import Ecto.Query
  alias Teamwork.PlayerEmail
  alias Teamwork.Mailer

  def send_tokenized_email(email) do
    contact = Parent |> where(email: ^email) |> Repo.one

    if contact do
      token = ParentSession.generate_token(contact)

      contact
      |> PlayerEmail.tokenized_email(token)
      |> Mailer.deliver_later
    end
  end
end
