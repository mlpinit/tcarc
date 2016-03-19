class GamesController < ApplicationController

  helper_method :game, :current_game_player
  attr_reader :game

  def new
    @game = current_user.games.new
  end

  def show
    @game = current_game_player.game
  end

  def create
    @game = current_user.games.new(permitted_params)
    action = CreateGame.new(game, current_user)
    if action.run
      redirect_to game_path(game)
    else
      render :new
    end
  end

  private

  def permitted_params
    params.require(:game).permit(:name, game_players_attributes: [:user_id])
  end

  def current_game_player
    @current_game_player ||= current_user.game_players.find_by(game_id: params[:id])
  end

end
