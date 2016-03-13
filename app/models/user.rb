class User < ActiveRecord::Base
  has_secure_password

  has_many :game_players
  has_many :games, foreign_key: "owner_id"

  def self.search(query)
    User.where("username LIKE ?", "%#{query}%").pluck(:username, :id)
  end

end
