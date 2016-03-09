class ChangeUserIdToGamePlayerIdForTiles < ActiveRecord::Migration[5.0]
  def change
    rename_column :tiles, :user_id, :game_player_id
  end
end
