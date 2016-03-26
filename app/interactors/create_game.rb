class CreateGame

  attr_reader :game, :current_user

  def initialize(game, current_user)
    @game = game
    @current_user = current_user
  end

  def allowed?
    return false if game.game_players.to_a.count > 4
    return unless game.valid?
    true
  end

  def run
    return unless allowed?
    game.game_players.new(user: current_user, invite: "accepted")
    game.tile_order = PreselectedTile.random_tile_order
    game.save!
    true
  end

end
