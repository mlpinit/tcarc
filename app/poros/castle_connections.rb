class CastleConnections < Connections

  def points
    (connections.count + barricade_points) * points_multiplier
  end

  private

  def barricade_points
    (barricade_connections & connections).count
  end

  def barricade_connections
    game_tiles
      .select { |tile| tile.barricade.present? }
      .map { |tile| [tile.id, tile.barricade] }
  end

  def points_multiplier
    if open?
      1
    else
      2
    end
  end

end
