class TilesController < ApplicationController

  def create
    action = PlaceTile.new(player: current_game_player, tile: tile)
    if action.run
      render plain: true, status: :ok
    else
      render nothing: true, status: :bad_request
    end
  end

  private

  def tile
    @tile = Tile.new(permitted_params)
  end

  def permitted_params
    params.require(:tile).permit(
      :x, :y, :north, :south, :west, :east, :monestary, :connected_road,
      :connected_castle, :start, :game_player_id, :game_id
    )
  end

  def current_game_player
    @current_game_player = current_user.game_players.find_by(id: tile.game_player_id)
  end

end
