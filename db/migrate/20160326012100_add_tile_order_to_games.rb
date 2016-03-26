class AddTileOrderToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :tile_order, :string
  end
end
