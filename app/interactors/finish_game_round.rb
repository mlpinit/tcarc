class FinishGameRound

  attr_reader :game, :game_tiles

  def initialize(game:, game_tiles:)
    @game       = game
    @game_tiles = game_tiles
  end

  def allowed?
    return false if game.current_game_player_id != last_tile.game_player_id
    true
  end

  def run
    return false unless allowed?
    process_castles_score
    process_roads_score
    process_monastery_score
    game.current_game_player = current_game_player.next_game_player
    true
  end

  private

  def process_monastery_score
    ProcessMonasteryScore.new(game_tiles: game_tiles).run
  end

  def process_roads_score
    closed_connected_road_groups.each do |roads|
      meeples = game.connected_meeples(roads.connections.sql_ready)
      ProcessScore.new(meeples: meeples, points: roads.points).run
    end
  end

  def process_castles_score
    closed_connected_castle_groups.each do |castles|
      meeples = game.connected_meeples(castles.connections.sql_ready)
      ProcessScore.new(meeples: meeples, points: castles.points).run
    end
  end

  def closed_connected_road_groups
    connected_road_groups.select do |connections|
      connections.closed?
    end
  end

  def closed_connected_castle_groups
    connected_castle_groups.select do |connections|
      connections.closed?
    end
  end
    
  def connected_road_groups
    if last_tile.connected_road
      [road_connections(roads_directions.first)]
    else
      roads_directions.map { |dir| road_connections(dir) }
    end
  end

  def connected_castle_groups
    if last_tile.connected_castle
      [castle_connections(castles_directions.first)]
    else
      castles_directions.map { |dir| castle_connections(dir) }
    end
  end

  def roads_directions
    @roads_directions = directions.select { |dir| last_tile.send(dir) == "road" }
  end

  def castles_directions
    @castles_directions = directions.select { |dir| last_tile.send(dir) == "castle" }
  end

  def road_connections(direction)
    RoadConnections.new(
      game_tiles: game_tiles,
      current_tile: last_tile,
      current_tile_direction: direction 
    )
  end

  def castle_connections(direction)
    CastleConnections.new(
      game_tiles: game_tiles,
      current_tile: last_tile,
      current_tile_direction: direction 
    )
  end

  def directions
    %w{south north east west}
  end

  def last_tile
    @last_tile ||= game_tiles.sort_by(&:created_at).last
  end

  def current_game_player
    @current_game_player ||= game.current_game_player
  end

end
