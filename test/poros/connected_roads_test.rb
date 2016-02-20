require 'test_helper'

class ConnectedRoadsTest < ActiveSupport::TestCase

  test "meeple composite keys" do
    assert_equal meeple_composite_keys1.sort, 
      ConnectedRoads
        .new(game_tiles: game_tiles1, meeple: meeple1)
        .connections
        .sort

    assert_equal meeple_composite_keys1v2.sort,
      ConnectedRoads
        .new(game_tiles: game_tiles1, meeple: meeple1v2)
        .connections
        .sort
  end


  test "meeple composite keys with end tiles" do
    assert_equal meeple_composite_keys2.sort,
      ConnectedRoads
        .new(game_tiles: game_tiles2, meeple: meeple2)
        .connections
        .sort

    assert_equal meeple_composite_keys2v2.sort,
      ConnectedRoads
        .new(game_tiles: game_tiles2, meeple: meeple2v2)
        .connections
        .sort

    assert_equal meeple_composite_keys3.sort,
      ConnectedRoads
        .new(game_tiles: game_tiles3, meeple: meeple3)
        .connections
        .sort

    assert_equal meeple_composite_keys3v2.sort,
      ConnectedRoads
        .new(game_tiles: game_tiles3, meeple: meeple3v2)
        .connections
        .sort
  end

  test "meeple composite keys loop" do
    assert_equal meeple_composite_keys4.sort,
      ConnectedRoads
        .new(game_tiles: game_tiles4, meeple: meeple4)
        .connections
        .sort
  end

  test "meeple composite keys loop with end road" do
    assert_equal meeple_composite_keys5.sort,
      ConnectedRoads
        .new(game_tiles: game_tiles5, meeple: meeple5)
        .connections
        .sort
  end

  private

  def game_tiles1
    [
      OpenStruct.new(id: 0, x: 0, y: 0, end_road: false, south: "road", north: "road"),
      OpenStruct.new(id: 1, x: 0, y: 1, end_road: false, south: "road", west: "road"),
      OpenStruct.new(id: 2, x: -1, y: 1, end_road: false, east: "road", north: "road"),
      OpenStruct.new(id: 3, x: -1, y: 2, end_road: false, south: "road", west: "road"),
      OpenStruct.new(id: 4, x: -2, y: 2, end_road: false, north: "road", east: "road"),
    ]
  end

  def game_tiles2
    [
      OpenStruct.new(id: 0, x: 0, y: 0, end_road: true, south: "road"),
      OpenStruct.new(id: 1, x: 0, y: -1, end_road: false, north: "road", south: "road"),
      OpenStruct.new(id: 2, x: 0, y: -2, end_road: false, north: "road", east: "road"),
      OpenStruct.new(id: 3, x: 1, y: -2, end_road: false, west: "road", east: "road"),
      OpenStruct.new(id: 4, x: 2, y: -2, end_road: false, west: "road", east: "road"),
      OpenStruct.new(id: 5, x: 3, y: -2, end_road: false, west: "road", east: "road"),
      OpenStruct.new(id: 6, x: 4, y: -2, end_road: false, west: "road", south: "road"),
      OpenStruct.new(id: 7, x: 4, y: -3, end_road: false, north: "road", south: "road"),
      OpenStruct.new(id: 8, x: 4, y: -4, end_road: true, north: "road")
    ]
  end

  def game_tiles3
    [
      OpenStruct.new(id: 0, x: 0, y: 0, end_road: true, east: "road"),
      OpenStruct.new(id: 1, x: 1, y: 0, end_road: false, west: "road", east: "road"),
      OpenStruct.new(id: 2, x: 2, y: 0, end_road: true, west: "road")
    ]
  end

  def game_tiles4
    [
      OpenStruct.new(id: 0, x: 0, y: 0, end_road: false, north: "road", east: "road"),
      OpenStruct.new(id: 1, x: 1, y: 0, end_road: false, west: "road", north: "road"),
      OpenStruct.new(id: 2, x: 1, y: 1, end_road: false, south: "road", west: "road"),
      OpenStruct.new(id: 3, x: 0, y: 1, end_road: false, south: "road", east: "road"),
    ]
  end

  def game_tiles5
    [
      OpenStruct.new(id: 0, x: 0, y: 0, end_road: true, north: "road", east: "road", west: "road"),
      OpenStruct.new(id: 1, x: 1, y: 0, end_road: false, west: "road", north: "road"),
      OpenStruct.new(id: 2, x: 1, y: 1, end_road: false, south: "road", west: "road"),
      OpenStruct.new(id: 3, x: 0, y: 1, end_road: false, east: "road", south: "road"),
    ]
  end

  def meeple1
    OpenStruct.new(tile_id: 2, direction: "north")
  end

  def meeple1v2
    OpenStruct.new(tile_id: 0, direction: "north")
  end

  def meeple2
    OpenStruct.new(tile_id: 0, direction: "south")
  end

  def meeple2v2
    OpenStruct.new(tile_id: 4, direction: "west")
  end

  def meeple3
    OpenStruct.new(tile_id: 0, direction: "east")
  end

  def meeple3v2
    OpenStruct.new(tile_id: 1, direction: "west")
  end

  def meeple4
    OpenStruct.new(tile_id: 0, direction: "east")
  end

  def meeple5
    OpenStruct.new(tile_id: 0, direction: "east")
  end

  def meeple_composite_keys1
    [
      [0, "south"], [0, "north"],
      [1, "south"], [1, "west"],
      [3, "south"], [3, "west"],
      [4, "north"], [4, "east"]
    ]
  end

  def meeple_composite_keys1v2
    [
      [1, "south"], [1, "west"],
      [2, "east"], [2, "north"],
      [3, "south"], [3, "west"],
      [4, "north"], [4, "east"]
    ]
  end

  def meeple_composite_keys2
    [
      [1, "north"], [1, "south"],
      [2, "north"], [2, "east"],
      [3, "west"], [3, "east"],
      [4, "west"], [4, "east"],
      [5, "west"], [5, "east"],
      [6, "west"], [6, "south"],
      [7, "north"], [7, "south"],
      [8, "north"]
    ]
  end

  def meeple_composite_keys2v2
    [
      [0, "south"], 
      [1, "north"], [1, "south"],
      [2, "north"], [2, "east"],
      [3, "west"], [3, "east"],
      [5, "west"], [5, "east"],
      [6, "west"], [6, "south"],
      [7, "north"], [7, "south"],
      [8, "north"]
    ]
  end

  def meeple_composite_keys3
    [[1, "west"], [1, "east"], [2, "west"]]
  end

  def meeple_composite_keys3v2
    [[0, "east"], [2, "west"]]
  end

  def meeple_composite_keys4
    [
      [1, "west"], [1, "north"],
      [2, "south"], [2, "west"],
      [3, "south"], [3, "east"],
    ]
  end

  def meeple_composite_keys5
    [
      [0, "north"],
      [1, "west"], [1, "north"],
      [2, "south"], [2, "west"],
      [3, "south"], [3, "east"],
    ]
  end

end
