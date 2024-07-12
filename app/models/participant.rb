class Participant < ApplicationRecord
  belongs_to :wheel, counter_cache: true
  validates :name, presence: true

  has_many :results
end
