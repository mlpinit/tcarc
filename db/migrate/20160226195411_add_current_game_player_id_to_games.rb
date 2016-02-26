class AddCurrentGamePlayerIdToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :current_game_player_id, :integer
  end
end
