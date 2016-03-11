class Game < ActiveRecord::Base
  has_many :meeples, -> { where(archived: false) }
  has_many :tiles
  has_many :game_players
  has_one  :current_game_player, class_name: "GamePlayer"

  def last_tile
    tiles.order("created_at DESC").limit(1).first
  end

  def connected_meeples(connections)
    meeples.where("(tile_id, direction) IN #{connections}")
  end

end
