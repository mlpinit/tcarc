class PlaceTile

  attr_reader :player, :tile, :game

  def initialize(player:, tile:)
    @player = player
    @tile = tile
    @game = player.game
  end

  def allowed?
    return false if player.game_id != tile.game_id
    return false if game.current_game_player_id != player.id
    return false unless tile.valid?
    true
  end

  def run
    return unless allowed?

    tile.save
    process_castles_score
    # process_roads_score
    # true
  end

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
      game_players.each do |gp|
        gp.score = gp.score + connections.points
        gp.save
      end
    end
  end
    
  def connected_castle_groups
    [].tap do |groups|
      if tile.connected_castle
        groups << castle_connections(castle_directions.first)
      else
        castle_directions.each { |dir| groups << castle_connections(dir) }
      end
    end
  end

  def castles_directions
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
