require "test_helper"

class GamesControllerTest < ActionController::TestCase

  test "#create - succcess" do
    john = users(:john)
    session[:user_id] = john.id

    game_params = {
      game: {
        name: "test1",
        game_players_attributes: [
          { user_id: 2 },
          { user_id: 3 },
          { user_id: 4 },
          { user_id: 5 }
        ]
      }
    }

    process(:create, method: :post, params: game_params)

    assert_response :found
    assert_equal 5, Game.last.game_players.count
  end

  test "#create - too many players" do
    john = users(:john)
    session[:user_id] = john.id

    game_params = {
      game: {
        name: "test1",
        game_players_attributes: [
          { user_id: 2 },
          { user_id: 3 },
          { user_id: 4 },
          { user_id: 5 },
          { user_id: 6 },
          { user_id: 7 }
        ]
      }
    }

    process(:create, method: :post, params: game_params)
    assert_template :new
  end

end
