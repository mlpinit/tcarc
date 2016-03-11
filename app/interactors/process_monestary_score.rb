class ProcessMonestaryScore

  attr_reader :game_tiles

  def initialize(game_tiles:)
    @game_tiles = game_tiles
  end

  def run
    game_tiles.with_monestaries.each do |tile|
      monestary = Monestary.new(game_tiles: game_tiles, current_tile: tile)
      if monestary.closed?
        player = tile.game_player
        player.increment(:score, monestary.points)
        player.increment(:remaining_meeples)
      end
    end
    true
  end

end
