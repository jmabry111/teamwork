defmodule Teamwork.PlayerQuery do
  alias Teamwork.Repo
  alias Teamwork.Player
  import Ecto.Query

  def find_player(id) do
    Player
    |> Repo.get!(id)
    |> Repo.preload([:parent])
  end

  def find_player(id, parent_id) do
    Player
    |> where(parent_id: ^parent_id)
    |> where(id: ^id)
    |> Repo.one
    |> Repo.preload([:parent])
  end

  def find_all() do
    Player
    |> Repo.all
  end
end
