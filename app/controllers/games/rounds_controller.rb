class Games::RoundsController < ApplicationController

  def create
    action = FinishGameRound.new(game: game, game_tiles: game.tiles)
    if action.run
      render plain: "OK", status: :ok
    else
      head :bad_request
    end
  end

  private

  def current_game_player
    @current_game_player ||= current_user.game_players.find_by(id: params[:game_id])
  end

  def game
    @game = current_game_player.game
  end

end
