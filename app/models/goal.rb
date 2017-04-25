class Goal < ApplicationRecord
  belongs_to :goal_category

  has_many :goal_observables, dependent: :destroy
  has_many :observables, through: :goal_observables

  validates :name, presence: true
end
