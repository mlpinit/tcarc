class Tile < ActiveRecord::Base

  validate :road_east_to_west, :road_west_to_east, :road_north_to_south, :road_south_to_north

  def road_east_to_west
    if east_neighbour && self.east != east_neighbour.west
      errors.add(:east, "road cannot be attached to west non-road")
    end
  end

  def road_west_to_east
    if west_neighbour && self.west != west_neighbour.east
      errors.add(:west, "road cannot be attached to east non-road")
    end
  end

  def road_north_to_south
    if north_neighbour && self.north != north_neighbour.south
      errors.add(:north, "road cannot be attached to south non-road")
    end
  end

  def road_south_to_north
    if south_neighbour && self.south != south_neighbour.north
      errors.add(:south, "road cannot be attached to north non-road")
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
