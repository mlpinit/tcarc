class CastleConnections < Connections

  private

  def extract(tile, direction)
    if tile.connected_castle
      collect_all_connections_ids(tile)
    else
      collect_single_connection_id(tile, direction)
    end
  end

  def available_directions(tile)
    directions.select { |dir| tile.send(dir) == "castle" }
  end

end
