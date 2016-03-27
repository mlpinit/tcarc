class PreselectedTile

  def self.find(id)
    all.find { |tile| tile.id == id }
  end

  def self.remaining_tiles(ids)
    ids
      .split("-1,")
      .last
      .split(",")
      .map(&:to_i)
      .map { |id| find(id) }
  end

  def self.random_tile_order
    "-1," + all.shuffle.map(&:id).join(",")
  end

  def self.all
    @all
  end

  def self.load(game_tiles)
    @all = game_tiles.map { |tile| new(tile) }
  end

  ATTRIBUTES = %w{
    id north south west east monastery
    barricade connected_castle connected_road
  }

  ATTRIBUTES.each { |attr| attr_reader attr }

  def initialize(**args)
    args.each { |name, value| instance_variable_set("@#{name}".to_sym, value) }
  end

end
