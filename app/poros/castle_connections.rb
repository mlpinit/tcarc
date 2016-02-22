class CastleConnections < Connections

  private

  def connected(tile)
    tile.connected_castle
  end

  def available_directions(tile)
    directions.select { |dir| tile.send(dir) == "castle" }
  end

end
