require 'test_helper'

class FinishGameRoundTest < ActiveSupport::TestCase

  class AllowedTest < FinishGameRoundTest

    test "#allowed? - success" do
      game = OpenStruct.new(id: 1, current_game_player_id: 1)
      tile = OpenStruct.new(id: 2, game_player_id: 1, created_at: Time.now)

      subject = FinishGameRound.new(game: game, game_tiles: [tile])
      assert subject.allowed?
    end

    test "#allowed? - failure" do
      game = OpenStruct.new(id: 1, current_game_player_id: 1)
      tile = OpenStruct.new(id: 2, game_player_id: 2, created_at: Time.now)
      subject = FinishGameRound.new(game: game, game_tiles: [tile])

      assert_not subject.allowed?
    end
  end

  class RunTest < FinishGameRoundTest

    #   |    -1         0         1
    # --|------------------------------
    #   | . F F F . . F F F . . F F F . 
    #   | F . F . F F . F . F F . F . F 
    # 1 | F F . F F F F . F F F F . F F 
    #   | F . F . F F . C . F F . F . F 
    #   | . F F F . . C C C . . F F F . 
    #   | . F F F . . C C C . . C C C .  
    #   | F . F . R R . C . R R . C . R 
    # 0 | F F . R R R R R R R R R . R R 
    #   | F . C . R R . F . R R . F . R 
    #   | . C C C . . F F F . . F F F . 

    test "two closed connected roads and one closed castle" do
      game = mock
      current_game_player = mock
      subject = FinishGameRound.new(game: game, game_tiles: game_tiles1)

      # allowed
      game.expects(:current_game_player_id).returns(1)

      # inside process roads/castles score
      game.expects(:connected_meeples).twice
      CastleConnections.any_instance.expects(:points).once
      RoadConnections.any_instance.expects(:points).once
      ProcessScore.any_instance.expects(:run).twice

      # monastery
      ProcessMonasteryScore.any_instance.expects(:run)
      
      # update next game player
      game.expects(:current_game_player).returns(current_game_player)
      current_game_player.expects(:next_game_player)
      game.expects(:current_game_player=).returns(current_game_player)

      assert subject.run
    end

    #   |    -1         0         1
    # --|------------------------------
    #   | . F F F . . C C C . . F F F . 
    #   | F . F . F R . C . R R . F . F 
    # 1 | F F . F F R R . R R R R . F F 
    #   | F . F . F R . R . R R . F . F 
    #   | . F F F . . R R R . . F F F . 
    #   | . F F F . . R R R . . F F F .  
    #   | F . F . F F . R . F F . F . F 
    # 0 | F F . F F F F . F F F F . F F 
    #   | F . F . F F . F . F F . F . F 
    #   | . F F F . . F F F . . F F F . 
    
    test "two closed roads" do
      game = mock
      current_game_player = mock
      subject = FinishGameRound.new(game: game, game_tiles: game_tiles2)

      # allowed
      game.expects(:current_game_player_id).returns(1)

      # inside process roads/castles score
      game.expects(:connected_meeples).twice
      RoadConnections.any_instance.expects(:points).twice
      ProcessScore.any_instance.expects(:run).twice

      # monastery
      ProcessMonasteryScore.any_instance.expects(:run)

      # update next game player
      game.expects(:current_game_player).returns(current_game_player)
      current_game_player.expects(:next_game_player)
      game.expects(:current_game_player=).returns(current_game_player)


      assert subject.run
    end

    private

    def game_tiles1
      [
        OpenStruct.new(
          id: 1, x: 0, y: 0, connected_road: true, connected_castle: false,
          north: "castle", south: "field", east: "road", west: "road",
          created_at: Time.now, game_player_id: 1
        ),
        OpenStruct.new(
          id: 2, x: 0, y: 1, connected_road: false, connected_castle: false,
          north: "field", south: "castle", east: "field", west: "field",
          created_at: 5.minutes.ago
        ),
        OpenStruct.new(
          id: 3, x: -1, y: 0, connected_road: false, connected_castle: false,
          north: "castle", south: "field", east: "field", west: "road",
          created_at: 5.minutes.ago
        ),
        OpenStruct.new(
          id: 4, x: 1, y: 0, connected_road: false, connected_castle: false,
          north: "castle", south: "field", east: "road", west: "road",
          created_at: 5.minutes.ago
        )
      ]
    end

    def current_game_player
      OpenStruct.new(id: 1, next_game_player: "Player2")
    end

    def game_tiles2
      [
        OpenStruct.new(
          id: 1, x: 0, y: 0, connected_road: false, connected_castle: false,
          north: "castle", south: "road", east: "road", west: "road",
          created_at: Time.now, game_player_id: 1
        ),
        OpenStruct.new(
          id: 2, x: 0, y: -1, connected_road: false, connected_castle: false,
          north: "road", south: "field", east: "field", west: "field",
          created_at: 5.minutes.ago
        ),
        OpenStruct.new(
          id: 3, x: 1, y: 0, connected_road: false, connected_castle: false,
          north: "field", south: "field", east: "field", west: "road",
          created_at: 5.minutes.ago
        )
      ]
    end

  end

end
