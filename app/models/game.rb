class Game < ActiveRecord::Base
  has_many :meeples
  has_many :tiles

  def last_tile
    tiles.order("created_at DESC").limit(1).first
  end

  def connected_meeples(connections)
    meeples.where("(tile_id, direction) IN #{connections}")
  end

end
