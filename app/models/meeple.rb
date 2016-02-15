class Meeple < ActiveRecord::Base
  belongs_to :user
  belongs_to :tile
  belongs_to :game

  validate :last_tile_placement, :no_field_placement, :road_overplacement, :castle_overplacement

  def last_tile_placement
    if game.last_tile != tile
      errors.add(:base, "Can only place meeple on last tile placed.")
    end
  end

  def no_field_placement
    if tile.send(direction) == "field"
      errors.add(:base, "Can't place meeple on field tile.")
    end
  end

  def road_overplacement
    return unless tile.send(direction) == "road"
    composite_keys_sql_ready = ConnectedRoads
      .new(game_tiles: game.tiles, meeple: self)
      .meeple_composite_keys_sql_ready
    meeples = game.meeples.where("(tile_id, direction) IN #{composite_keys_sql_ready}")

    if meeples.present?
      errors.add(:base, "Can't place meeple on a road with another meeple.")
    end
  end

  def castle_overplacement
    return unless tile.send(direction) == "castle"
    composite_keys_sql_ready = ConnectedCastles
      .new(game_tiles: game.tiles, meeple: self)
      .connections_composite_keys_sql_ready
    meeples = game.meeples.where("(tile_id, direction) IN #{composite_keys_sql_ready}")

    if meeples.present?
      errors.add(:base, "Can't place meeple on a castle with another meeple.")
    end
  end

end
