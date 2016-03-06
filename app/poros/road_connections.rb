class RoadConnections < Connections

  def points
    connections.map(&:first).uniq.count + not_connected_loop_point
  end

  private

  def not_connected_loop_point
    if open?
      0
    else
      closed_connected_tiles.uniq.count == 1 ? 1 : 0
    end
  end

end
