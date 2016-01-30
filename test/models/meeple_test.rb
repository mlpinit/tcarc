require 'test_helper'

class MeepleTest < ActiveSupport::TestCase

  test "allow meeple placed on the last tile and no other tile" do
    john = users(:john)
    game = games(:one)

    tile = Tile.create!(x: -1, y: 0, north: "road", south: "road", west: "road",
      east: "road", monestary: false, end_road: false, start: false, game: game)

    meeple = john.meeples.new(tile: tile, game: game, direction: "north")

    assert meeple.valid?

    Tile.create!(x: -2, y: 0, north: "road", south: "road", west: "road",
      east: "road", monestary: false, end_road: false, start: false, game: game)

    assert_raise ActiveRecord::RecordInvalid do
      john.meeples.create!(tile: tile, game: game, direction: "north")
    end
  end

  # test "don't allow meeple on a field" do
  #   skip
  # end

  # test "allow meeple on a road with no other meeples on it" do
  #   skip
  # end

  # test "allow meeple on a road with another meeple that belongs to the same player" do
  #   skip
  # end

  # test "don't allow meeple on a road connected to another player's meeple" do
  #   skip
  # end

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
