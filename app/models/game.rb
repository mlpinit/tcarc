class Game < ActiveRecord::Base
  has_many :meeples, -> { where(archived: false) }
  has_many :tiles
  has_many :game_players
  has_one  :current_game_player, class_name: "GamePlayer"
  belongs_to :owner, class_name: "User", foreign_key: "owner_id"

  accepts_nested_attributes_for :game_players

  def last_tile
    tiles.order("created_at DESC").limit(1).first
  end

  def connected_meeples(connections)
    meeples.where("(tile_id, direction) IN #{connections}")
  end

  def shift_tile_order!
    self.tile_order = "#{tile_order[-1]},#{tile_order[0..-3]}"
    save!
  end

  def remaining_tiles
    PreselectedTile.remaining_tiles(tile_order)
  end

end
