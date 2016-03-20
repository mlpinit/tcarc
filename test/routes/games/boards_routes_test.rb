require "test_helper"

class Games::BoardsRoutesTest < ActionDispatch::IntegrationTest

  test "boards#show" do
    assert_routing(
      { method: "GET", path: "/games/1/board" },
      { controller: "games/boards", action: "show", game_id: "1"}
    )
  end

end
