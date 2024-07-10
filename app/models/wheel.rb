class Wheel < ApplicationRecord
  belongs_to :user
  has_many :participants
  validates :title, presence: true 
end
