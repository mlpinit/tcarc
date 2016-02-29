require 'test_helper'

class MeepleTest < ActiveSupport::TestCase

  attr_reader :john, :game

  setup do
    @john = game_players(:one)
    @game = games(:one)
  end

  test "allow meeple placed on the last tile and no other tile" do
    tile = Tile.create!(x: -1, y: 0, north: "road", south: "road", west: "road",
      east: "road", start: false, game: game)

    meeple = john.meeples.new(tile: tile, game: game, direction: "north")

    assert meeple.valid?

    Tile.create!(x: -2, y: 0, north: "road", south: "road", west: "road",
      east: "road", start: false, game: game)

    exception = assert_raise ActiveRecord::RecordInvalid do
      john.meeples.create!(tile: tile, game: game, direction: "north")
    end
    assert_equal "Validation failed: Can only place meeple on last tile placed.", exception.message
  end

  test "don't allow meeple on a field" do
    tile = Tile.create!(x: 5, y: 4, north: "field", south: "field", west: "field",
      east: "field", start: false, game: game)

    exception = assert_raise ActiveRecord::RecordInvalid do
      john.meeples.create!(game: game, tile: tile, direction: "south")
    end
    assert_equal "Validation failed: Can't place meeple on field tile.", exception.message
  end

  test "don't allow a meeple on a road that already has a meeple" do
    tile = Tile.create!(x: 22, y: 0, east: "road", west: "road", south: "field", north: "field", start: true, game: game)
    john.meeples.create!(tile: tile, game: game, direction: "east")
    tile = Tile.create!(x: 23, y: 0, east: "road", west: "road", south: "field", north: "field",  start: false, game: game)
    exception = assert_raise ActiveRecord::RecordInvalid do
      john.meeples.create!(tile: tile, game: game.reload, direction: "west")
    end
    assert_equal "Validation failed: Can't place meeple on a road with another meeple.", exception.message
  end

  test "don't allow a meeple on a castle with another meeple" do
    tile = Tile.create!(x: 44, y: 0, east: "field", west: "field", south: "castle", north: "field", start: true, game: game)
    john.meeples.create!(tile: tile, game: game, direction: "south")
    tile = Tile.create!(x: 44, y: -1, east: "field", west: "field", south: "field", north: "castle",  start: false, game: game)
    exception = assert_raise ActiveRecord::RecordInvalid do
      john.meeples.create!(tile: tile, game: game.reload, direction: "north")
    end
    assert_equal "Validation failed: Can't place meeple on a castle with another meeple.", exception.message
  end
  
end
