class User < ApplicationRecord
  has_secure_password
  has_many :wheels
  has_many :participants

  validates :username, presence: true, uniqueness: true
end
