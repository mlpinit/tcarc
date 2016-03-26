class PlaceTile

  attr_reader :player, :tile

  def initialize(player:, tile:)
    @player = player
    @tile = tile
  end

  def allowed?
    return false if player.game_id != tile.game_id
    return false if player.game.current_game_player_id != player.id
    return false unless tile.valid?
    true
  end

  def run
    return false unless allowed?
    tile.save
    tile.game.shift_tile_order!
    true
  end

end
