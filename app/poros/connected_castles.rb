class ConnectedCastles
  include TileConnection

  attr_reader :game_tiles, :meeple

  def initialize(game_tiles:, meeple:)
    @game_tiles = game_tiles
    @meeple = meeple
    @connections = []
    extract(current_tile, meeple.direction)
  end

  private

  def extract(tile, direction)
    if tile.connected_castle
      collect_all_connections_ids(tile)
    else
      collect_single_connection_id(tile, direction)
    end
  end

  def collect_all_connections_ids(tile)
    castles_directions = directions.select { |dir| tile.send(dir) == "castle" }
    castles_directions.each { |dir| collect_single_connection_id(tile, dir) }
  end

  def collect_single_connection_id(tile, direction)
    composite_key = [tile.id, direction]
    return if connections.include?(composite_key)
    connections << composite_key 
    neighbour = neighbour(tile.x, tile.y, direction)
    extract(neighbour, opposite_direction(direction)) if neighbour
  end

end
