filename = Rails.root.join("db/game_tiles.json")
game_tiles = JSON.parse(File.read(filename))

PreselectedTile.load(game_tiles.map(&:symbolize_keys))
