class Wheel < ApplicationRecord
  belongs_to :user
  has_many :participants
  has_many :results
  validates :title, presence: true 
end
