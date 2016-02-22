class RoadConnections < Connections

  private 

  def connected(tile)
    !tile.end_road
  end

  def available_directions(tile)
    directions.select { |dir| tile.send(dir) == "road" }
  end

end
