class Wheel < ApplicationRecord
  belongs_to :user
  has_many :names
  validates :title, presence: true 
end
