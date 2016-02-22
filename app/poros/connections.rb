class Connections

  attr_reader :game_tiles, :current_tile, :current_tile_direction

  def initialize(game_tiles:, current_tile:, current_tile_direction:)
    @game_tiles             = game_tiles
    @current_tile           = current_tile
    @current_tile_direction = current_tile_direction
    extract(current_tile, current_tile_direction)
  end

  def connections
    @connections ||= [].extend(SqlReady)
  end

  private

  def available_directions(tile)
    raise "#available_directions needs to be implemented in subclass!"
  end

  def collect_all_connections_ids(tile)
    available_directions(tile).each do |dir|
      collect_single_connection_id(tile, dir)
    end
  end

  def collect_single_connection_id(tile, direction)
    connection = [tile.id, direction]
    return if connections.include?(connection)
    connections << connection 
    neighbour = neighbour(tile.x, tile.y, direction)
    extract(neighbour, opposite_direction(direction)) if neighbour
  end

  def directions
    %w{south north east west}
  end

  def opposite_direction(direction)
    {
      "south" => "north",
      "north" => "south",
      "west" => "east",
      "east" => "west"
    }[direction]
  end

  def neighbour(x, y, direction)
    x = x - 1 if direction == "west"
    x = x + 1 if direction == "east"
    y = y - 1 if direction == "south"
    y = y + 1 if direction == "north"
    game_tiles.find { |t| t.x == x && t.y == y }
  end

  module SqlReady
    def sql_ready
      if self.present?
        self.to_s.gsub("[", "(").gsub("]",")").gsub('"', '\'')
      else
        "((NULL, NULL))"
      end
    end
  end

end
