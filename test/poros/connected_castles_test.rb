require 'test_helper'

class ConnectedCastlesTest < ActiveSupport::TestCase

  test 'same tile castle not connected' do
    assert_equal game_tiles1_expected, ConnectedCastles
      .new(game_tiles: game_tiles1, meeple: meeple)
      .connections
  end

  test 'same tile connected castle' do
    assert_equal game_tiles2_expected, ConnectedCastles
      .new(game_tiles: game_tiles2, meeple: meeple)
      .connections
      .sort
  end

  test "connected and not connected combo" do
    assert_equal game_tiles3_expected, ConnectedCastles
      .new(game_tiles: game_tiles3, meeple: meeple)
      .connections
      .sort
  end

  test "fully closed castle" do
    assert_equal game_tiles4_expected, ConnectedCastles
      .new(game_tiles: game_tiles4, meeple: meeple)
      .connections
      .sort
  end

  private

  def meeple
    OpenStruct.new(tile_id: 0, direction: "north")
  end

  def game_tiles1
    [
      OpenStruct.new(
        id: 0, x: 0, y: 0, connected_castle: false,
        south: "field", west: "field", north: "castle", east: "castle")
    ]
  end

  def game_tiles1_expected
    [[0, "north"]]
  end

  def game_tiles2
    [
      OpenStruct.new(
        id: 0, x: 0, y: 0, connected_castle: true,
        south: "field", west: "field", north: "castle", east: "castle")
    ]
  end

  def game_tiles3
    [
      OpenStruct.new(
        id: 0, x: 0, y: 0, connected_castle: false,
        south: "field", west: "field", north: "castle", east: "castle"),
      OpenStruct.new(
        id: 1, x: 0, y: 1, connected_castle: true,
        south: "field", west: "field", south: "castle", east: "castle"),
      OpenStruct.new(
        id: 2, x: 1, y: 1, connected_castle: true,
        south: "field", west: "castle", south: "castle", east: "field", north: "castle")
    ]
  end

  def game_tiles4
    [
      OpenStruct.new(id: 0, x: 0, y: 0, connected_castle: true,
        south: "castle", west: "castle", north: "castle", east: "castle"),
      OpenStruct.new(id: 1, x: 1, y: 0, connected_castle: false,
        south: "field", west: "castle", north: "field", east: "field"),
      OpenStruct.new(id: 2, x: 0, y: 1, connected_castle: false,
        south: "castle", west: "field", north: "field", east: "field"),
      OpenStruct.new(id: 3, x: 0, y: -1, connected_castle: false,
        south: "field", west: "field", north: "castle", east: "field"),
      OpenStruct.new(id: 4, x: -1, y: 0, connected_castle: true,
        south: "field", west: "castle", north: "field", east: "castle"),
      OpenStruct.new(id: 5, x: -2, y: 0, connected_castle: true,
        south: "field", west: "field", north: "castle", east: "castle"),
      OpenStruct.new(id: 6, x: -2, y: 1, connected_castle: false,
        south: "castle", west: "field", north: "field", east: "field")
    ]
  end

  def game_tiles2_expected
    [[0, "east"], [0, "north"]].sort
  end

  def game_tiles3_expected
    [
      [0, "north"],
      [1, "east"], [1, "south"],
      [2, "west"], [2, "north"], [2, "south"]
    ].sort
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

end