class User < ApplicationRecord
  has_many :apps, dependent: :destroy

  has_secure_password
  validates :username, presence: true, length: {minimum: 3}, uniqueness: true
  validates :password_digest, presence: true
end
