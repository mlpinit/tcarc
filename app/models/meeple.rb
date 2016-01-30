class Meeple < ActiveRecord::Base
  belongs_to :user
  belongs_to :tile
  belongs_to :game

  validate :last_tile

  def last_tile
    if game.last_tile != tile
      errors.add(:base, "Can only place meeple on last tile placed.")
    end
  end

end
