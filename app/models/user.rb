class User < ActiveRecord::Base
  has_many :posts

  has_secure_password

  validates :username, :password_digest, presence: true
end
