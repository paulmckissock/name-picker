class Wheel < ApplicationRecord
  belongs_to :user
  has_many :participants, dependent: :destroy
  has_many :results, dependent: :destroy
  validates :title, presence: true
end
