class GamePlayer < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  has_one :next_game_player, class: "GamePlayer", foreign_key: :next_game_player_id
end
