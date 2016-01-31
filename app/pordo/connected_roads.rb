class ConnectedRoads

  attr_reader :game_tiles, :meeple, :connections

  def initialize(game_tiles: game_tiles, meeple: meeple)
    @game_tiles  = game_tiles
    @meeple      = meeple
    @connections = []
  end

  def meeple_composite_keys
    collect_meeple_identifiers(*next_pair(current_tile, meeple.direction))
    unless current_tile.end_road || unintrerupted_loop?
      od = other_direction(current_tile, meeple.direction)
      collect_meeple_identifiers(*next_pair(current_tile, od)) 
    end
    connections
  end

  private

  def collect_meeple_identifiers(tile, direction)
    return unless tile # openended road
    return if tile == current_tile && !tile.end_road # looping road
    connections << [tile.id, direction]
    return if tile.end_road # end road
    od = other_direction(tile, direction)
    connections << [tile.id, od]
    collect_meeple_identifiers(*next_pair(tile, od))
  end

  def next_pair(tile, direction)
    [neighbour(tile.x, tile.y, direction), opposite_direction(direction)]
  end

  def other_direction(tile, direction)
    %w{south north east west}.select { |dir| dir != direction }.find do |dir|
      tile.send(dir) == "road"
    end
  end

  def current_tile
    @current_tile = game_tiles.find { |t| t.id == meeple.tile_id }
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

  def unintrerupted_loop?
    od = other_direction(current_tile, meeple.direction)
    tile = next_pair(current_tile, od).first
    connections.map(&:first).include?(tile.try(:id))
  end

end
