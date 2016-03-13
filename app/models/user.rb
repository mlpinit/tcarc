class User < ActiveRecord::Base
  has_secure_password

  has_many :game_players
  has_many :games, foreign_key: "owner_id"

  def self.username_search(query, username)
    User
      .where("username LIKE ?", "%#{query}%")
      .where("username NOT LIKE ?", "%#{username}%")
      .pluck(:username, :id)
  end

end
