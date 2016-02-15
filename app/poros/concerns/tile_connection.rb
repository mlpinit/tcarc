module TileConnection

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

  def current_tile
    @current_tile = game_tiles.find { |t| t.id == meeple.tile_id }
  end

end
