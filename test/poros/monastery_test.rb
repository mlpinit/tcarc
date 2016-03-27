require 'test_helper'

class MonasteryTest < ActiveSupport::TestCase

  test 'closed monastery' do
    monastery = Monastery.new(game_tiles: game_tiles1, current_tile: current_tile)
    assert_equal 9, monastery.points
    assert_not monastery.open?
  end

  test 'open monastery' do
    monastery = Monastery.new(game_tiles: game_tiles2, current_tile: current_tile)
    assert_equal 6, monastery.points
    assert monastery.open?
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
