class Monestary

  attr_reader :game_tiles, :current_tile

  def initialize(game_tiles:, current_tile:)
    @game_tiles = game_tiles
    @current_tile = current_tile
  end

  def open?
    points != 9
  end

  def closed?
    !open?
  end

  def points
    @points ||= (game_tile_coordinates & neighbour_coordinates).count + 1
  end

  private

  def game_tile_coordinates
    game_tiles.map { |tile| [tile.x, tile.y] }
  end

  def neighbour_coordinates
    x, y = current_tile.x, current_tile.y
    [
      [x - 1, y + 1],
      [x, y + 1],
      [x + 1, y + 1],
      [x + 1, y],
      [x + 1, y - 1],
      [x, y - 1],
      [x - 1, y - 1],
      [x - 1, y]
    ]
  end

end
