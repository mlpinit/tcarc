class ChangeUserIdToGamePlayerIdForMeeples < ActiveRecord::Migration[5.0]
  def change
    rename_column :meeples, :user_id, :game_player_id
  end
end
