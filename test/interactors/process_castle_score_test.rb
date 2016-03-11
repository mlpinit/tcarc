require 'test_helper'

class ProcessCastleScoreTileTest < ActiveSupport::TestCase

  test "one player meeples" do
    subject = ProcessCastleScore.new(meeples: meeples1, points: 4)

    player1.expects(:increment).with(:remaining_meeples, 2)
    player1.expects(:increment).with(:score, 4)

    Array.any_instance.expects(:update_all).with(archived: true)

    subject.run
  end

  test "multiple players meeples" do
    subject = ProcessCastleScore.new(meeples: meeples2, points: 6)

    player1.expects(:increment).with(:remaining_meeples, 2)
    player1.expects(:increment).with(:score, 6)

    player2.expects(:increment).with(:remaining_meeples, 2)
    player2.expects(:increment).with(:score, 6)

    Array.any_instance.expects(:update_all).with(archived: true)

    subject.run
  end

  private

  def meeples1
    [
      OpenStruct.new(id: 1, game_player_id: 1, game_player: player1),
      OpenStruct.new(id: 2, game_player_id: 1, game_player: player1)
    ]
  end

  def meeples2
    [
      OpenStruct.new(id: 1, game_player_id: 1, game_player: player1),
      OpenStruct.new(id: 2, game_player_id: 1, game_player: player1),
      OpenStruct.new(id: 3, game_player_id: 2, game_player: player2),
      OpenStruct.new(id: 4, game_player_id: 2, game_player: player2),
      OpenStruct.new(id: 5, game_player_id: 3, game_player: player3)
    ]
  end

  def player1
    @player1 ||= mock
  end

  def player2
    @player2 ||= mock
  end

  def player3
    @player3 ||= mock
  end

end
