class AddCastleEndToTile < ActiveRecord::Migration
  def change
    add_column :tiles, :castle_end, :boolean, default: false
  end
end
