defmodule Teamwork.User do
  use Teamwork.Web, :model
  import Doorman.Auth.Bcrypt, only: [hash_password: 1]

  schema "users" do
    field :email, :string
    field :hashed_password, :string
    field :password, :string, virtual: true

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :password])
    |> validate_required([:email, :password])
    |> hash_password
    |> unique_constraint(:email)
  end
end
