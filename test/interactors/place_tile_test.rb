require 'test_helper'

class PlaceTileTest < ActiveSupport::TestCase

  class AllowedTest < PlaceTileTest

    test "#allowed? - wrong game" do
      player = OpenStruct.new(game_id: 1)
      tile = OpenStruct.new(game_id: 2)

      subject = PlaceTile.new(player: player, tile: tile)
      assert_not subject.allowed?
    end

    test "#allowed? - not yo turn" do
      game = OpenStruct.new(id: 1, current_game_player_id: 2)
      player = OpenStruct.new(id: 1, game_id: 1, game: game)
      tile = OpenStruct.new(game_id: 1)

      subject = PlaceTile.new(player: player, tile: tile)
      assert_not subject.allowed?
    end

    test "#allowed? - tile not valid" do
      game = OpenStruct.new(id: 1, current_game_player_id: 1)
      player = OpenStruct.new(id: 1, game_id: 1, game: game)
      tile = OpenStruct.new(game_id: 1, valid?: false)

      subject = PlaceTile.new(player: player, tile: tile)
      assert_not subject.allowed?
    end

    test '#allowed? - success' do
      game = OpenStruct.new(id: 1, current_game_player_id: 1)
      player = OpenStruct.new(id: 1, game_id: 1, game: game)
      tile = OpenStruct.new(game_id: 1, valid?: true)

      subject = PlaceTile.new(player: player, tile: tile)
      assert subject.allowed?
    end
  end

  class RunTest < PlaceTileTest
  end

end
