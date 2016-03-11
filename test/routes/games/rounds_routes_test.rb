require "test_helper"

class Games::RoundsRoutesTest < ActionDispatch::IntegrationTest

  test "rounds#create" do
    assert_routing(
      { method: "POST", path: "/games/1/rounds" },
      { controller: "games/rounds", action: "create", game_id: "1"}
    )
  end

end
