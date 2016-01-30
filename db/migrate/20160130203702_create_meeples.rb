class CreateMeeples < ActiveRecord::Migration
  def change
    create_table :meeples do |t|
      t.integer :user_id
      t.integer :game_id
      t.integer :tile_id
      t.string :direction

      t.timestamps null: false
    end
  end
end
