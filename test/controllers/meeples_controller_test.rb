require "test_helper"

class MeeplesControllerTest < ActionController::TestCase

  test "#create - success" do
    john = users(:john)
    tile = tiles(:first_placed)
    session[:user_id] = john.id

    PlaceMeeple.any_instance.expects(:run).returns(true)

    meeple_params = {
      meeple: {
        game_id: 1,
        game_player_id: 1,
        tile_id: tile.id,
        direction: "north"
      }
    }
    process(:create, method: :post, params: meeple_params)

    assert_response :ok
  end

  test "#create - failure" do
    john = users(:john)
    tile = tiles(:first_placed)
    session[:user_id] = john.id

    PlaceMeeple.any_instance.expects(:run).returns(false)

    meeple_params = {
      meeple: {
        game_id: 1,
        game_player_id: 1,
        tile_id: tile.id,
        direction: "north"
      }
    }
    process(:create, method: :post, params: meeple_params)

    assert_response :bad_request
  end



end
