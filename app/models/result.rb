class Result < ApplicationRecord
  belongs_to :participant
  belongs_to :user
  belongs_to :wheel

  validates :participant, presence: true
  validates :wheel, presence: true
end
