require 'test_helper'

class MonestaryTest < ActiveSupport::TestCase

  test 'closed monestary' do
    monestary = Monestary.new(game_tiles: game_tiles1, current_tile: current_tile)
    assert_equal 9, monestary.points
    assert_not monestary.open?
  end

  test 'open monestary' do
    monestary = Monestary.new(game_tiles: game_tiles2, current_tile: current_tile)
    assert_equal 6, monestary.points
    assert monestary.open?
  end

  private

  def current_tile
    OpenStruct.new(x: 0, y: 0)
  end

  def game_tiles1
    [
      current_tile,
      OpenStruct.new(x: -1, y: 1),
      OpenStruct.new(x: 0, y: 1),
      OpenStruct.new(x: 1, y: 1),
      OpenStruct.new(x: 1, y: 0),
      OpenStruct.new(x: 1, y: -1),
      OpenStruct.new(x: 0, y: -1),
      OpenStruct.new(x: -1, y: -1),
      OpenStruct.new(x: -1, y: 0)
    ]
  end

  def game_tiles2
    [
      current_tile,
      OpenStruct.new(x: -1, y: 1),
      OpenStruct.new(x: 0, y: 1),
      OpenStruct.new(x: 1, y: 1),
      OpenStruct.new(x: 1, y: 0),
      OpenStruct.new(x: 1, y: -1)
    ]
  end
  
end
