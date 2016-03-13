require "test_helper"

class GamesRoutesTest < ActionDispatch::IntegrationTest

  test "games#new" do
    assert_routing({ method: "GET", path: "/games/new" }, { controller: "games", action: "new" })
  end

  test "games#create" do
    assert_routing({ method: "POST", path: "/games" }, { controller: "games", action: "create" })
  end

  test "games#show" do
    assert_routing({ method: "GET", path: "/games/1" }, { controller: "games", action: "show", id: '1' })
  end


end
