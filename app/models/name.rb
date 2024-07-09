class Name < ApplicationRecord
  belongs_to :wheel, counter_cache: true
  validates :has_won, inclusion: { in: [true, false] }
  validates :text, presence: true
end
