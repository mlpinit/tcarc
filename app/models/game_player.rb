class GamePlayer < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  has_many :meeples, -> { where(archived: false) }
  has_one :next_game_player, class_name: "GamePlayer", foreign_key: :next_game_player_id
  has_many :tiles

  enum invite: { pending: 0, accepted: 1 }

  validates :game_id, uniqueness: { scope: :user_id }
end
