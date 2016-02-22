require 'test_helper'

class ConnectedRoadsTest < ActiveSupport::TestCase

  test "meeple composite keys" do
    assert_equal connections1.sort, ConnectedRoads
      .new(game_tiles: game_tiles1, current_tile: current_tile1, current_tile_direction: "north")
      .connections
      .sort

    assert_equal connections1v2.sort, ConnectedRoads
      .new(game_tiles: game_tiles1, current_tile: current_tile1v2, current_tile_direction: "north")
      .connections
      .sort
  end


  test "meeple composite keys with end tiles" do
    assert_equal connections2.sort, ConnectedRoads
      .new(game_tiles: game_tiles2, current_tile: current_tile2, current_tile_direction: "south")
      .connections
      .sort

    assert_equal connections2v2.sort, ConnectedRoads
      .new(game_tiles: game_tiles2, current_tile: current_tile2v2, current_tile_direction: "west")
      .connections
      .sort

    assert_equal connections3.sort, ConnectedRoads
      .new(game_tiles: game_tiles3, current_tile: current_tile3, current_tile_direction: "east")
      .connections
      .sort

    assert_equal connections3v2.sort, ConnectedRoads
      .new(game_tiles: game_tiles3, current_tile: current_tile3v2, current_tile_direction: "west")
      .connections
      .sort
  end

  test "meeple composite keys loop" do
    assert_equal connections4.sort, ConnectedRoads
      .new(game_tiles: game_tiles4, current_tile: current_tile4, current_tile_direction: "east")
      .connections
      .sort
  end

  test "meeple composite keys loop with end road" do
    assert_equal connections5.sort, ConnectedRoads
      .new(game_tiles: game_tiles5, current_tile: current_tile5, current_tile_direction: "east")
      .connections
      .sort
  end

  private

  def game_tiles1
    [
      current_tile1v2,
      OpenStruct.new(id: 1, x: 0, y: 1, end_road: false, south: "road", west: "road"),
      current_tile1,
      OpenStruct.new(id: 3, x: -1, y: 2, end_road: false, south: "road", west: "road"),
      OpenStruct.new(id: 4, x: -2, y: 2, end_road: false, north: "road", east: "road"),
    ]
  end

  def current_tile1
    OpenStruct.new(id: 2, x: -1, y: 1, end_road: false, east: "road", north: "road")
  end

  def current_tile1v2
    OpenStruct.new(id: 0, x: 0, y: 0, end_road: false, south: "road", north: "road")
  end

  def connections1
    [
      [0, "south"], [0, "north"],
      [1, "south"], [1, "west"],
      [2, "east"], [2, "north"],
      [3, "south"], [3, "west"],
      [4, "north"], [4, "east"]
    ]
  end

  def connections1v2
    [
      [0, "south"], [0, "north"],
      [1, "south"], [1, "west"],
      [2, "east"], [2, "north"],
      [3, "south"], [3, "west"],
      [4, "north"], [4, "east"]
    ]
  end

  def game_tiles2
    [
      current_tile2,
      OpenStruct.new(id: 1, x: 0, y: -1, end_road: false, north: "road", south: "road"),
      OpenStruct.new(id: 2, x: 0, y: -2, end_road: false, north: "road", east: "road"),
      OpenStruct.new(id: 3, x: 1, y: -2, end_road: false, west: "road", east: "road"),
      current_tile2v2,
      OpenStruct.new(id: 5, x: 3, y: -2, end_road: false, west: "road", east: "road"),
      OpenStruct.new(id: 6, x: 4, y: -2, end_road: false, west: "road", south: "road"),
      OpenStruct.new(id: 7, x: 4, y: -3, end_road: false, north: "road", south: "road"),
      OpenStruct.new(id: 8, x: 4, y: -4, end_road: true, north: "road")
    ]
  end

  def current_tile2
    OpenStruct.new(id: 0, x: 0, y: 0, end_road: true, south: "road")
  end

  def current_tile2v2
    OpenStruct.new(id: 4, x: 2, y: -2, end_road: false, west: "road", east: "road")
  end

  def connections2
    [
      [0, "south"],
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

  def connections2v2
    [
      [0, "south"], 
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


  def game_tiles3
    [
      current_tile3,
      current_tile3v2,
      OpenStruct.new(id: 2, x: 2, y: 0, end_road: true, west: "road")
    ]
  end

  def current_tile3
    OpenStruct.new(id: 0, x: 0, y: 0, end_road: true, east: "road")
  end

  def current_tile3v2
    OpenStruct.new(id: 1, x: 1, y: 0, end_road: false, west: "road", east: "road")
  end

  def connections3
    [[0, "east"], [1, "west"], [1, "east"], [2, "west"]]
  end

  def connections3v2
    [[0, "east"], [1, "west"], [1, "east"], [2, "west"]]
  end


  def game_tiles4
    [
      current_tile4,
      OpenStruct.new(id: 1, x: 1, y: 0, end_road: false, west: "road", north: "road"),
      OpenStruct.new(id: 2, x: 1, y: 1, end_road: false, south: "road", west: "road"),
      OpenStruct.new(id: 3, x: 0, y: 1, end_road: false, south: "road", east: "road"),
    ]
  end

  def current_tile4
    OpenStruct.new(id: 0, x: 0, y: 0, end_road: false, north: "road", east: "road")
  end

  def connections4
    [
      [0, "east"], [0, "north"],
      [1, "west"], [1, "north"],
      [2, "south"], [2, "west"],
      [3, "south"], [3, "east"],
    ]
  end

  def game_tiles5
    [
      current_tile5,
      OpenStruct.new(id: 1, x: 1, y: 0, end_road: false, west: "road", north: "road"),
      OpenStruct.new(id: 2, x: 1, y: 1, end_road: false, south: "road", west: "road"),
      OpenStruct.new(id: 3, x: 0, y: 1, end_road: false, east: "road", south: "road"),
    ]
  end

  def current_tile5
    OpenStruct.new(id: 0, x: 0, y: 0, end_road: true, north: "road", east: "road", west: "road")
  end

  def connections5
    [
      [0, "east"], [0, "north"],
      [1, "west"], [1, "north"],
      [2, "south"], [2, "west"],
      [3, "south"], [3, "east"],
    ]
  end

end
