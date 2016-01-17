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

  test "allow castle attach from east to west" do
    tile = Tile.new(x: 1, y: 2, east: "castle")
    tile.valid?
    assert tile.errors.empty?
  end

  test "don't allow castle attach to non-castle from east to west" do
    tile = Tile.new(x: -1, y: 0, east: "castle")
    tile.valid?
    assert_equal tile.errors.full_messages.first, 
      "East castle cannot be attached to west non-castle"
  end

  test "allow castle attach from west to east" do
    tile = Tile.new(x: 3, y: 2, west: "castle")
    tile.valid?
    assert tile.errors.empty?
  end

  test "don't allow castle attach to non-castle from west to east" do
    tile = Tile.new(x: 5, y: 4, west: "castle")
    tile.valid?
    assert_equal tile.errors.full_messages.first, 
      "West castle cannot be attached to east non-castle"
  end

  test "allow castle attach from north to south" do
    tile = Tile.new(x: 2, y: 1, north: "castle")
    tile.valid?
    assert tile.errors.empty?
  end

  test "don't allow castle attach to non-castle from north to south" do
    tile = Tile.new(x: 0, y: -1, north: "castle")
    tile.valid?
    assert_equal tile.errors.full_messages.first, 
      "North castle cannot be attached to south non-castle"
  end

  test "allow castle attach from south to north" do
    tile = Tile.new(x: 2, y: 3, south: "castle")
    tile.valid?
    assert tile.errors.empty?
  end

  test "don't allow castle attach to non-castle from south to north" do
    tile = Tile.new(x: 0, y: 1, south: "castle")
    tile.valid?
    assert_equal tile.errors.full_messages.first, 
      "South castle cannot be attached to north non-castle"
  end

  test "allow field attach from east to west" do
    tile = Tile.new(x: 3, y: 4, east: "field")
    tile.valid?
    assert tile.errors.empty?
  end

  test "don't allow field attach to non-field from east to west" do
    tile = Tile.new(x: 1, y: 2, east: "field")
    tile.valid?
    assert_equal tile.errors.full_messages.first, 
      "East field cannot be attached to west non-field"
  end

  test "allow field attach from west to east" do
    tile = Tile.new(x: 5, y: 4, west: "field")
    tile.valid?
    assert tile.errors.empty?
  end

  test "don't allow field attach to non-field from west to east" do
    tile = Tile.new(x: 1, y: 0, west: "field")
    tile.valid?
    assert_equal tile.errors.full_messages.first, 
      "West field cannot be attached to east non-field"
  end

  test "allow field attach from north to south" do
    tile = Tile.new(x: 4, y: 3, north: "field")
    tile.valid?
    assert tile.errors.empty?
  end

  test "don't allow field attach to non-field from north to south" do
    tile = Tile.new(x: 0, y: -1, north: "field")
    tile.valid?
    assert_equal tile.errors.full_messages.first, 
      "North field cannot be attached to south non-field"
  end

  test "allow field attach from south to north" do
    tile = Tile.new(x: 4, y: 5, south: "field")
    tile.valid?
    assert tile.errors.empty?
  end

  test "don't allow field attach to non-field from south to north" do
    tile = Tile.new(x: 0, y: 1, south: "field")
    tile.valid?
    assert_equal tile.errors.full_messages.first, 
      "South field cannot be attached to north non-field"
  end

end
