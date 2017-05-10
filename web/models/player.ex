defmodule Teamwork.Player do
  use Teamwork.Web, :model
  use Timex.Ecto.Timestamps

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "players" do
    field :name, :string
    field :birthdate, Timex.Ecto.Date
    field :school, :string
    field :grade_level, :string
    field :gender, :string
    field :age, :integer

    belongs_to :parent, Teamwork.Parent, type: :binary_id

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, required_fields())
    |> validate_required(required_fields())
    |> foreign_key_constraint(:parent_id)
    |> calculate_age()
  end

  defp required_fields() do
    ~w(
      birthdate
      parent_id
      grade_level
      name
      school
      gender
    )a
  end

  def schools do
    [
      "Axton Elementary",
      "Bassett High School",
      "Campbell Court Elementary",
      "Carver Elementary",
      "Collinsville Primary",
      "Drewry Mason Elementary",
      "Fieldale-Collinsville Middle School",
      "John Redd Elementary",
      "Laurel Park Middle School",
      "Magna Vista High School",
      "Mount Olivet Elementary",
      "Rich Acres Elementary",
      "Sanville Elementary",
      "Stanleytown Elementary",
      "Other",
    ]
  end

  def calculate_age(changeset) do
    case get_field(changeset, :birthdate) do
      nil ->
        changeset
      _ ->
        birthday = get_field(changeset, :birthdate)
        age = Timex.diff(Timex.today, birthday, :years)
        put_change(changeset, :age, age)
    end
  end
end
