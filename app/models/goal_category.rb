class GoalCategory < ApplicationRecord
  has_many :goals, -> { order(:name) }
end
