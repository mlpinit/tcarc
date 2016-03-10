require 'test_helper'

class PlaceMeepleTest < ActiveSupport::TestCase

  class AllowedTest < PlaceMeepleTest

    test "#allowed? - not yo game" do
      player = OpenStruct.new(game_id: 2, remaining_meeples: 1)
      meeple = OpenStruct.new(game_id: 1, valid?: true)

      subject = PlaceMeeple.new(player: player, meeple: meeple)
      assert_not subject.allowed?
    end

    test "#allowed? - no meeples left" do
      player = OpenStruct.new(game_id: 1, remaining_meeples: 0)
      meeple = OpenStruct.new(game_id: 1, valid?: true)

      subject = PlaceMeeple.new(player: player, meeple: meeple)
      assert_not subject.allowed?
    end

    test "#allowed? - meeples invalid" do
      player = OpenStruct.new(game_id: 1, remaining_meeples: 1)
      meeple = OpenStruct.new(game_id: 1, valid?: false)

      subject = PlaceMeeple.new(player: player, meeple: meeple)
      assert_not subject.allowed?
    end

    test "#allowed? - success" do
      player = OpenStruct.new(game_id: 1, remaining_meeples: 1)
      meeple = OpenStruct.new(game_id: 1, valid?: true)

      subject = PlaceMeeple.new(player: player, meeple: meeple)
      assert subject.allowed?
    end
  end

end
