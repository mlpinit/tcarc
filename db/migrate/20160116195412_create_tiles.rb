class CreateTiles < ActiveRecord::Migration
  def change
    create_table :tiles do |t|
      t.integer :x
      t.integer :y
      t.string :north
      t.string :south
      t.string :west
      t.string :east
      t.boolean :monestary, default: false
      t.boolean :end_road, default: false

      t.timestamps null: false
    end
  end
end
