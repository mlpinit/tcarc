require 'test_helper'

class CreateGameTest < ActiveSupport::TestCase

  class AllowedTest < CreateGameTest

    test "#allowed? - failure" do
      john = users(:john)

      game = john.games.new(name: "test1")
      game.game_players.new(user: users(:two))
      game.game_players.new(user: users(:three))
      game.game_players.new(user: users(:four))
      game.game_players.new(user: users(:five))
      game.game_players.new(user: users(:six))

      subject = CreateGame.new(game, john)
      assert_not subject.allowed?
    end

    test "#allowed? - success" do
      john = users(:john)

      game = john.games.new(name: "test1")
      game.game_players.new(user: users(:two))
      game.game_players.new(user: users(:three))

      subject = CreateGame.new(game, john)
      assert subject.allowed?
    end

  end

  class RunTest < CreateGameTest

    test "#run" do
      john = users(:john)

      game = john.games.new(name: "test1")
      game.game_players.new(user: users(:two))
      game.game_players.new(user: users(:three))

      subject = CreateGame.new(game, john)
      assert subject.run
      assert_equal "accepted", game.game_players.find_by(user_id: john.id).invite
    end

  end

end
