class AddBarricaedAttributeToTiles < ActiveRecord::Migration[5.0]
  def change
    add_column :tiles, :barricade, :string
  end
end
