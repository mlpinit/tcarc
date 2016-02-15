class AddCastleEndToTile < ActiveRecord::Migration
  def change
    add_column :tiles, :connected_castle, :boolean, default: false
  end
end
