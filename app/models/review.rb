class Review < ApplicationRecord
  belongs_to :game
  belongs_to :player

  validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  validates :comment, presence: true
end
