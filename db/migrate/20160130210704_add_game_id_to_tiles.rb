class AddGameIdToTiles < ActiveRecord::Migration
  def change
    add_column :tiles, :game_id, :integer
  end
end
