require "test_helper"

class Games::RoundsControllerTest < ActionController::TestCase

  test "#create - success" do
    john = users(:john)
    session[:user_id] = john.id
    FinishGameRound.any_instance.expects(:run).returns(true)

    process(:create, method: :post, params: { game_id: 1 })
    assert_response :ok
  end

  test "#create - failure" do
    john = users(:john)
    session[:user_id] = john.id
    FinishGameRound.any_instance.expects(:run).returns(false)

    process(:create, method: :post, params: { game_id: 1 })
    assert_response :bad_request
  end

end
