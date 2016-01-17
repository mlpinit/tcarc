require 'test_helper'

class TileTest < ActiveSupport::TestCase

  test "allow road attach from east to west" do
    tile = Tile.new(x: -1, y: 0, east: "road")
    tile.valid?
    assert tile.errors.empty?
  end

  test "don't allow road attach to non-road from east to west" do
    tile = Tile.new(x: 1, y: 2, east: "road")
    tile.valid?
    assert_equal tile.errors.full_messages.first, 
      "East road cannot be attached to west non-road"
  end

  test "allow road attach from west to east" do
    tile = Tile.new(x: 1, y: 0, west: "road")
    tile.valid?
    assert tile.errors.empty?
  end

  test "don't allow road attach to non-road from west to east" do
    tile = Tile.new(x: 3, y: 2, west: "road")
    tile.valid?
    assert_equal tile.errors.full_messages.first, 
      "West road cannot be attached to east non-road"
  end

  test "allow road attach from north to south" do
    tile = Tile.new(x: 0, y: -1, north: "road")
    tile.valid?
    assert tile.errors.empty?
  end

  test "don't allow road attach to non-road from north to south" do
    tile = Tile.new(x: 2, y: 1, north: "road")
    tile.valid?
    assert_equal tile.errors.full_messages.first, 
      "North road cannot be attached to south non-road"
  end

  test "allow road attach from south to north" do
    tile = Tile.new(x: 0, y: 1, south: "road")
    tile.valid?
    assert tile.errors.empty?
  end

  test "don't allow road attach to non-road from south to north" do
    tile = Tile.new(x: 2, y: 3, south: "road")
    tile.valid?
    assert_equal tile.errors.full_messages.first, 
      "South road cannot be attached to north non-road"
  end

end
