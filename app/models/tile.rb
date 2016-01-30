class Tile < ActiveRecord::Base
  belongs_to :user
  belongs_to :game
  has_many :meeples

  validate :east_to_west, :west_to_east, :north_to_south, :south_to_north, :start_tile
  validates :north, :south, :west, :east, presence: true
  validates :game_id, presence: true

  def start_tile
    neighbours = [:east, :west, :south, :north].map do |direction|
      send("#{direction}_neighbour")
    end.compact

    if neighbours.empty? && !start
      errors.add(:base, "Can't place non-starting tile as a standalone tile.")
    end
  end

  def east_to_west
    if east_neighbour && self.east != east_neighbour.west
      errors.add(:east, "#{east} cannot be attached to west non-#{east}")
    end
  end

  def west_to_east
    if west_neighbour && self.west != west_neighbour.east
      errors.add(:west, "#{west} cannot be attached to east non-#{west}")
    end
  end

  def north_to_south
    if north_neighbour && self.north != north_neighbour.south
      errors.add(:north, "#{north} cannot be attached to south non-#{north}")
    end
  end

  def south_to_north
    if south_neighbour && self.south != south_neighbour.north
      errors.add(:south, "#{south} cannot be attached to north non-#{south}")
    end
  end

  def east_neighbour
    Tile.find_by(x: x + 1, y: y)
  end

  def west_neighbour
    Tile.find_by(x: x - 1, y: y)
  end

  def north_neighbour
    Tile.find_by(x: x, y: y + 1)
  end

  def south_neighbour
    Tile.find_by(x: x, y: y - 1)
  end

end
