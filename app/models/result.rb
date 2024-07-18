class Result < ApplicationRecord
  belongs_to :user
  belongs_to :wheel
  belongs_to :participant, optional: true
  validates :participant_name, presence: true
  validates :wheel, presence: true
end
