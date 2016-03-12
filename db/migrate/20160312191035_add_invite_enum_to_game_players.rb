class AddInviteEnumToGamePlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :game_players, :invite, :integer, default: 0
  end
end
