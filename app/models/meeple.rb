class Meeple < ActiveRecord::Base
  belongs_to :game_player
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

    if connected_meeples.present?
      errors.add(:base, "Can't place meeple on a road with another meeple.")
    end
  end

  def castle_overplacement
    return unless tile.send(direction) == "castle"

    if connected_meeples.present?
      errors.add(:base, "Can't place meeple on a castle with another meeple.")
    end
  end

  private

  def connections
    @connections ||= Connections
      .new(game_tiles: game.tiles, current_tile: tile, current_tile_direction: direction)
      .connections
  end

  def connected_meeples
    game.connected_meeples(connections.sql_ready)
  end

end
