require 'test_helper'

class MeepleTest < ActiveSupport::TestCase

  attr_reader :john, :game

  setup do
    @john = users(:john)
    @game = games(:one)
  end

  test "allow meeple placed on the last tile and no other tile" do
    tile = Tile.create!(x: -1, y: 0, north: "road", south: "road", west: "road",
      east: "road", start: false, game: game)

    meeple = john.meeples.new(tile: tile, game: game, direction: "north")

    assert meeple.valid?

    Tile.create!(x: -2, y: 0, north: "road", south: "road", west: "road",
      east: "road", start: false, game: game)

    assert_raise ActiveRecord::RecordInvalid do
      john.meeples.create!(tile: tile, game: game, direction: "north")
    end
  end

  test "don't allow meeple on a field" do
    tile = Tile.create!(x: 5, y: 4, north: "field", south: "field", west: "field",
      east: "field", start: false, game: game)

    assert_raise ActiveRecord::RecordInvalid do
      john.meeples.create!(game: game, tile: tile, direction: "south")
    end
  end

  test "don't allow a meeple on a road that already has a meeple" do
    tile = Tile.create!(x: 22, y: 0, north: "road", east: "road", west: "road", south: "field", north: "field", start: true, game: game)
    john.meeples.create!(tile: tile, game: game, direction: "west")
    tile = Tile.create!(x: 23, y: 0, north: "road", east: "road", west: "road", south: "field", north: "field",  start: false, game: game)
    assert_raise ActiveRecord::RecordInvalid do
      john.meeples.create!(tile: tile, game: game.reload, direction: "east")
    end
  end

  # test "allow meeple on a castle with no other meeples on it" do
  #   skip
  # end

  # test "allow meeple on a castle with another meeple that belongs to the same player" do
  #   skip
  # end

  # test "don't allow a meeple on a castle with another player's meeple" do
  #   skip
  # end
  
  # test "don't allow user to place meeple on another users's tile" do
  # end

end
