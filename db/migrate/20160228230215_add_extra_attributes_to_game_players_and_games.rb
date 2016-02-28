class AddExtraAttributesToGamePlayersAndGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :started, :boolean, default: false
    add_column :game_players, :remaining_meeples, :integer, default: 0
    add_column :game_players, :color, :string
  end
end
