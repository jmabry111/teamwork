defmodule Teamwork.Repo.Migrations.CreateParentsAndPlayers do
  use Ecto.Migration

  def change do
    create table(:parents, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :email, :string, null: false
      add :phone, :string, null: false
      add :name, :string, null: false
      add :city, :string, null: false
      add :state, :string, null: false
      add :zip, :string, null: false
      add :street, :string, null: false

      timestamps()
    end
    create unique_index(:parents, [:email])
  end
end
