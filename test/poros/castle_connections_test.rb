require 'test_helper'

class CastleConnectionsTest < ActiveSupport::TestCase

  test 'same tile castle not connected' do
    subject = CastleConnections.new(
      game_tiles: game_tiles1,
      current_tile: current_tile1,
      current_tile_direction: "north"
    )
    assert_equal game_tiles1_expected, subject.connections
    assert_equal 1, subject.points
    assert subject.open?
  end

  test 'same tile connected castle' do
    subject = CastleConnections.new(
      game_tiles: game_tiles2,
      current_tile: current_tile2,
      current_tile_direction: "north"
    )
    assert_equal game_tiles2_expected, subject.connections.sort
    assert_equal 2, subject.points
    assert subject.open?
  end

  test "connected and not connected combo" do
    subject = CastleConnections.new(
      game_tiles: game_tiles3,
      current_tile: current_tile3,
      current_tile_direction: "north"
    )
    assert_equal game_tiles3_expected, subject.connections.sort
    assert_equal 3, subject.points
    assert subject.open?
  end

  test "fully closed castle" do
    subject = CastleConnections.new(
      game_tiles: game_tiles4,
      current_tile: current_tile4,
      current_tile_direction: "north"
    )
    assert_equal game_tiles4_expected, subject.connections.sort
    assert_equal 16, subject.points
    assert_not subject.open?
  end

  test "castle loop" do
    subject = CastleConnections.new(
      game_tiles: game_tiles5,
      current_tile: current_tile5,
      current_tile_direction: "west"
    )
    assert_equal 18, subject.points
    assert_not subject.open?
  end

  private
  
  def current_tile1
    OpenStruct.new(
      id: 0, x: 0, y: 0, connected_castle: false,
      south: "field", west: "field", north: "castle", east: "castle"
    )
  end

  def game_tiles1
    [current_tile1]
  end

  def game_tiles1_expected
    [[0, "north"]]
  end


  def current_tile2
    OpenStruct.new(
      id: 0, x: 0, y: 0, connected_castle: true,
      south: "field", west: "field", north: "castle", east: "castle",
      barricade: "east"
    )
  end

  def game_tiles2
    [current_tile2]
  end

  def game_tiles2_expected
    [[0, "east"], [0, "north"]].sort
  end

  def current_tile4
    OpenStruct.new(
      id: 0, x: 0, y: 0, connected_castle: true,
      south: "castle", west: "castle", north: "castle", east: "castle"
    )
  end

  def game_tiles3
    [
      current_tile3,
      OpenStruct.new(
        id: 1, x: 0, y: 1, connected_castle: true,
        west: "field", south: "castle", east: "castle"
      ),
      OpenStruct.new(
        id: 2, x: 1, y: 1, connected_castle: true,
        west: "castle", south: "castle", east: "field", north: "castle"
      )
    ]
  end

  def current_tile3
    OpenStruct.new(
      id: 0, x: 0, y: 0, connected_castle: false,
      south: "field", west: "field", north: "castle", east: "castle"
    )
  end

  def game_tiles3_expected
    [
      [0, "north"],
      [1, "east"], [1, "south"],
      [2, "west"], [2, "north"], [2, "south"]
    ].sort
  end

  def game_tiles4
    [
      current_tile4,
      OpenStruct.new(
        id: 1, x: 1, y: 0, connected_castle: false,
        south: "field", west: "castle", north: "field", east: "field"
      ),
      OpenStruct.new(
        id: 2, x: 0, y: 1, connected_castle: false,
        south: "castle", west: "field", north: "field", east: "field"
      ),
      OpenStruct.new(
        id: 3, x: 0, y: -1, connected_castle: false,
        south: "field", west: "field", north: "castle", east: "field"
      ),
      OpenStruct.new(
        id: 4, x: -1, y: 0, connected_castle: true,
        south: "field", west: "castle", north: "field", east: "castle",
        barricade: "west"
      ),
      OpenStruct.new(
        id: 5, x: -2, y: 0, connected_castle: true,
        south: "field", west: "field", north: "castle", east: "castle"
      ),
      OpenStruct.new(
        id: 6, x: -2, y: 1, connected_castle: false,
        south: "castle", west: "field", north: "field", east: "field"
      )
    ]
  end

  def game_tiles4_expected
    [
      [0, "north"], [0, "south"], [0, "west"], [0, "east"],
      [1, "west"], [2, "south"], [3, "north"],
      [4, "west"], [4, "east"],
      [5, "east"], [5, "north"],
      [6, "south"]
    ].sort
  end

  def game_tiles5
    [
      current_tile5,
      OpenStruct.new(
        id: 1, x: 2, y: 3, connected_castle: true,
        south: "field", west: "castle", north: "field", east: "castle"
      ),
      OpenStruct.new(
        id: 2, x: 1, y: 3, connected_castle: true,
        south: "castle", west: "field", north: "field", east: "castle"
      ),
      OpenStruct.new(
        id: 3, x: 1, y: 2, connected_castle: true,
        south: "castle", west: "field", north: "castle", east: "field"
      ),
      OpenStruct.new(
        id: 4, x: 1, y: 1, connected_castle: true,
        south: "field", west: "field", north: "castle", east: "castle"
      ),
      OpenStruct.new(
        id: 5, x: 2, y: 1, connected_castle: true,
        south: "field", west: "castle", north: "field", east: "castle"
      ),
      OpenStruct.new(
        id: 6, x: 3, y: 1, connected_castle: true,
        south: "field", west: "castle", north: "castle", east: "field"
      ),
      OpenStruct.new(
        id: 7, x: 3, y: 2, connected_castle: true,
        south: "castle", west: "field", north: "castle", east: "field"
      )
    ]
  end

  def current_tile5
    OpenStruct.new(
      id: 0, x: 3, y: 3, connected_castle: false,
      south: "field", west: "castle", north: "south", east: "field"
    )
  end

end
