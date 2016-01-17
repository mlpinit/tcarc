class AddStarterColumnToTiles < ActiveRecord::Migration
  def change
    add_column :tiles, :start, :boolean, default: false
  end
end
