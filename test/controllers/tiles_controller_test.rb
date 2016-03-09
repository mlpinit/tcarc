require "test_helper"

class TilesControllerTest < ActionController::TestCase

  test "#create - success" do
    john = users(:john)
    session[:user_id] = john.id

    tile_params = {
      tile: {
        x: 0, y: -1, north: "road", south: "road", west: "road", east: "road",
        monestary: false, connected_road: true, connected_castle: false, start: false,
        game_player_id: 1, game_id: 1
      }
    }
    process(:create, method: :post, params:  tile_params)
    assert_response :ok
  end

  test "#create - failure" do
    john = users(:john)
    session[:user_id] = john.id

    PlaceTile.any_instance.expects(:run).returns(false)

    tile_params = {
      tile: {
        x: 0, y: -1, north: "road", south: "road", west: "road", east: "road",
        monestary: false, connected_road: true, connected_castle: false, start: false,
        game_player_id: 3, game_id: 2
      }
    }
    process(:create, method: :post, params:  tile_params)
    
    assert_response :bad_request
  end

end
