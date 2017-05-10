defmodule Teamwork.Repo.Migrations.CreatePlayers do
  use Ecto.Migration

  def change do
    create table(:players, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :school, :string, null: false
      add :birthdate, :date, null: false
      add :grade_level, :string, null: false
      add :gender, :string, null: false
      add :age, :integer, default: 0, null: false
      add :parent_id, references(:parents, type: :binary_id, on_delete: :delete_all), null: false

      timestamps()
    end
    create index(:players, [:parent_id])
  end
end
