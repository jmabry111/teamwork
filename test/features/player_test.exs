defmodule Teamwork.Feature.PlayerTest do
  use Teamwork.FeatureCase
  alias Teamwork.Parent

  test "register a player" do
    parent = insert(:parent, email: "johnnysmom@example.com")

    navigate_to "/parents/#{parent.id}/players/new?as_parent=#{parent.id}"

    fill_in "player", "name", with: "Johnny Rocket"
    fill_in "player", "grade_level", with: "5"
    select "Axton Elementary", from: "school"
    select "Male", from: "gender"
    submit()

    assert visible_page_text() =~ "Players for #{parent.name}"

    parent = Parent |> Repo.one |> Repo.preload(:players)
    player = parent.players |> List.first
    assert parent.email == "johnnysmom@example.com"
    assert player.name == "Johnny Rocket"
    assert player.age != nil
  end
end
