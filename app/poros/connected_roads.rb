class ConnectedRoads
  include TileConnection

  attr_reader :game_tiles, :current_tile, :current_tile_direction

  def initialize(game_tiles:, current_tile:, current_tile_direction:)
    @game_tiles             = game_tiles
    @current_tile           = current_tile
    @current_tile_direction = current_tile_direction

    collect_connections(*next_pair(current_tile, current_tile_direction))
    unless current_tile.end_road || unintrerupted_loop?
      od = other_direction(current_tile, current_tile_direction)
      collect_connections(*next_pair(current_tile, od)) 
    end
  end

  private

  def collect_connections(tile, direction)
    return unless tile # openended road
    return if tile == current_tile && !tile.end_road # looping road
    connections << [tile.id, direction]
    return if tile.end_road # end road
    od = other_direction(tile, direction)
    connections << [tile.id, od]
    collect_connections(*next_pair(tile, od))
  end

  def next_pair(tile, direction)
    [neighbour(tile.x, tile.y, direction), opposite_direction(direction)]
  end

  def other_direction(tile, direction)
    directions.select { |dir| dir != direction }.find do |dir|
      tile.send(dir) == "road"
    end
  end

  def unintrerupted_loop?
    od = other_direction(current_tile, current_tile_direction)
    tile = next_pair(current_tile, od).first
    connections.map(&:first).include?(tile.try(:id))
  end

end
