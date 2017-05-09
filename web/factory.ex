defmodule Teamwork.Factory do
  use ExMachina.Ecto, repo: Teamwork.Repo

  def user_factory do
    %Teamwork.User{
      email: sequence(:email, &"user#{&1}@example.com"),
      password: "password",
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
