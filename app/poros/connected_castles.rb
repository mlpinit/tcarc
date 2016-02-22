class ConnectedCastles
  include TileConnection

  attr_reader :game_tiles, :current_tile, :current_tile_direction

  def initialize(game_tiles:, current_tile:, current_tile_direction:)
    @game_tiles             = game_tiles
    @current_tile           = current_tile
    @current_tile_direction = current_tile_direction
    extract(current_tile, current_tile_direction)
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
    connection = [tile.id, direction]
    return if connections.include?(connection)
    connections << connection 
    neighbour = neighbour(tile.x, tile.y, direction)
    extract(neighbour, opposite_direction(direction)) if neighbour
  end

end
