class RoadConnections < Connections

  private 

  def extract(tile, direction)
    if tile.end_road
      collect_single_connection_id(tile, direction)
    else
      collect_all_connections_ids(tile)
    end
  end

  def available_directions(tile)
    directions.select { |dir| tile.send(dir) == "road" }
  end

end
