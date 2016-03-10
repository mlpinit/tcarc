class MeeplesController < ApplicationController

  def create
    action = PlaceMeeple.new(player: current_game_player, meeple: meeple)
    if action.run
      render plain: "OK", status: :ok
    else
      render nothing: true, status: :bad_request
    end
  end

  private

  def meeple
    @meeple = Meeple.new(permitted_params)
  end

  def permitted_params
    params.require(:meeple)
      .permit(:game_id, :game_player_id, :tile_id, :direction)
  end

  def current_game_player
    @current_game_player = current_user.game_players.find_by(id: meeple.game_player_id)
  end
 
end
