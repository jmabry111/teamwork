defmodule Teamwork.Factory do
  use ExMachina.Ecto, repo: Teamwork.Repo

  def user_factory do
    %Teamwork.User{
      email: sequence(:email, &"user#{&1}@example.com"),
      password: "password",
    }
  end

  def parent_factory do
    %Teamwork.Parent{
      email: sequence(:email, &"parent-#{&1}@example.com"),
      name: "Player's Dad",
      phone: "5551231212",
      street: sequence(:street, &"#{&1} Main Street"),
      city: "Anywhere",
      state: "ST",
      zip: "99999",
    }
  end

  def player_factory do
    %Teamwork.Player{
      name: sequence(:name, &"Ball Player #{&1}"),
      birthdate: Timex.shift(Timex.today, years: -10),
      school: "Tha Bomb Elementary",
      grade_level: "4",
      gender: "Male",
      parent: build(:parent),
    }
  end

  def save(struct) do
    module_name = struct.__struct__
    params = Map.from_struct(struct)

    module_name
    |> struct(%{})
    |> module_name.changeset(params)
    |> Teamwork.Repo.insert!
  end
end
