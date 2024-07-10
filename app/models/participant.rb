class Participant < ApplicationRecord
  belongs_to :wheel, counter_cache: true
  validates :text, presence: true
end
