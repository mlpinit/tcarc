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

  def open?
    !!connections.find do |connection|
      tile = game_tiles.find { |t| t.id == connection.first }
      neighbour(tile.x, tile.y, connection.last).nil?
    end
  end

  def closed?
    !open?
  end

  private

  def type
    # infer if we are looking for road or castle connections
    current_tile.send(current_tile_direction)
  end

  def extract(tile, direction)
    if tile.send("connected_#{type}")
      collect_all_connections_ids(tile)
    else
      collect_single_connection_id(tile, direction)
    end
  end

  def available_directions(tile)
    directions.select { |dir| tile.send(dir) == type }
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

  def connected_tiles
    connections.map(&:first).map do |id|
      game_tiles.find { |tile| tile.id == id }
    end
  end

  def closed_connected_tiles
    connected_tiles.select do |tile|
      !tile.send("connected_#{type}")
    end
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
