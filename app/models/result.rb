class Result < ApplicationRecord
  belongs_to :user
  belongs_to :wheel
  validates :participant_name, presence: true
  validates :wheel, presence: true
end
