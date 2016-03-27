class FixTypoInTiles < ActiveRecord::Migration[5.0]
  def change
    rename_column :tiles, :monestary, :monastery
  end
end
