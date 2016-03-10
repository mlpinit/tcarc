class PlaceMeeple

  attr_reader :player, :meeple

  def initialize(player:, meeple:)
    @player = player
    @meeple = meeple
  end

  def allowed?
    return false if player.game_id != meeple.game_id
    return false if player.remaining_meeples == 0
    return false unless meeple.valid?
    true
  end

  def run
    return unless allowed?
    meeple.save!
    player.decrement(:remaining_meeples)
    true
  end

end
