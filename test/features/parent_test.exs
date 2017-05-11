defmodule Teamwork.Feature.ParentTest do
  use Teamwork.FeatureCase
  use Bamboo.Test, shared: :true

  test "a parent can register" do
    navigate_to "/"
    fill_in "parent", "name", with: "Joe Blow"
    fill_in "parent", "email", with: "joe@example.com"
    fill_in "parent", "phone", with: "5555555555"
    fill_in "parent", "street", with: "123 Main St."
    fill_in "parent", "city", with: "Anywhere"
    fill_in "parent", "state", with: "ST"
    fill_in "parent", "zip", with: "99999"

    click_on "Submit"

    assert visible_page_text() =~ "Great! Now let's add a player!"
  end

  test "a parent can add other participants" do
    parent = insert(:parent)
    player = insert(:player, parent: parent)

    navigate_to "/players/#{player.id}?as_parent=#{parent.id}"

    click_on "Register Another Player"

    assert visible_page_text() =~ "New player"
  end

  test "parents can see all of their players" do
    parent = insert(:parent)
    jonny = insert(:player, name: "Jonny", parent: parent)
    jenny = insert(:player, name: "Jenny", parent: parent)

    navigate_to "/parents/#{parent.id}?as_parent=#{parent.id}"

    assert visible_page_text() =~ jonny.name
    assert visible_page_text() =~ jenny.name
  end

  test "a parent receives a link to come back later to add more players" do
    parent = insert(:parent)
    token = Phoenix.Token.sign(Teamwork.Endpoint, "parent", parent.email)

    navigate_to "/"

    fill_in "parent", "name", with: parent.name
    fill_in "parent", "email", with: parent.email
    fill_in "parent", "phone", with: parent.phone
    fill_in "parent", "street", with: parent.street
    fill_in "parent", "city", with: parent.city
    fill_in "parent", "state", with: parent.state
    fill_in "parent", "zip", with: parent.zip

    click_on "Submit"

    email = Teamwork.PlayerEmail.tokenized_email(parent, token)
    email |> Teamwork.Mailer.deliver_now

    assert visible_page_text() =~ "Hey! Looks like you've been here before. Please check your email for a link to add more players."
    assert_delivered_email Teamwork.PlayerEmail.tokenized_email(parent, token)
  end
end
