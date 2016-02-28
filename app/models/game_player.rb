class GamePlayer < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  has_one :next_game_player, class_name: "GamePlayer", foreign_key: :next_game_player_id
end
