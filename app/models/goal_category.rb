class GoalCategory < ApplicationRecord
  has_many :goals, -> { order(:name) }

  validates :name, presence: true
end
