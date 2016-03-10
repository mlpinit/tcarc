class UpdateScore


  private

  def process_castles_score
    connected_castle_groups.select do |connections|
      connections.closed?
    end.each do |connections|
      meeples = game.connected_meeples(connections.sql_ready)
      group = meeples
        .group_by { |meeple| meeple.game_player_id }
        .map { |k,v| [k, v = v.count] }
        .to_h
      game_players = group
        .select { |meeple,count| count == group.values.max }
        .keys
        .map(&:game_player)
        .uniq
      game_players.each do |game_player|
        game_player.increment(:score, connections.points)
      end
      group.each do |meeple,count|
        meeple.game_player.increment(:remaining_meeples, count)
      end
    end
  end
    
  def connected_castle_groups
    castles_directions.map { |dir| castle_connections(dir) }
  end

  def castles_directios
    @castles_directions = directions.select { |dir| tile.send(dir) == "castle" }
  end

  def castle_connections(direction)
    CastleConnections.new(
      game_tiles: game_tiles,
      current_tile: tile,
      current_tile_direction: direction 
    )
  end

  def connected_roads
  end

  def directions
    %w{south north east west}
  end

  def game_tiles
    @game_tiles ||= game.tiles
  end

end
