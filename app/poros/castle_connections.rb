class CastleConnections < Connections

  def points
    (
      connections.map(&:first).uniq.count +
        barricade_points +
        not_connected_loop_points
    ) * points_multiplier
  end

  private

  def not_connected_loop_points
    closed_connected_tiles.group_by do |tile|
      tile.id
    end.map do |k,v|
      [k,v.count]
    end.to_h.select { |k,v| v == 2 }.count
  end

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
