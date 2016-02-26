class CreateGamePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :game_players do |t|
      t.integer :user_id
      t.integer :game_id
      t.integer :next_game_player_id
      t.integer :score

      t.timestamps
    end
  end
end
