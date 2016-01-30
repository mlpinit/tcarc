class User < ActiveRecord::Base
  has_secure_password

  has_many :tiles
  has_many :meeples
end
