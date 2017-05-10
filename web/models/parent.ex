defmodule Teamwork.Parent do
  use Teamwork.Web, :model

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "parents" do
    field :email, :string
    field :name, :string
    field :phone, :string
    field :street, :string
    field :city, :string
    field :state, :string
    field :zip, :string

    has_many :players, Teamwork.Player, on_delete: :delete_all

    timestamps()
  end

  defp required_fields() do
    [
      :name,
      :email,
      :phone,
      :street,
      :city,
      :state,
      :zip,
    ]
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, required_fields())
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/.+@.+/)
    |> validate_required(required_fields())
  end
end
