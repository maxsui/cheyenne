class Goal < ApplicationRecord
  belongs_to :goal_category

  has_many :goal_observables, dependent: :destroy
  has_many :observables, through: :goal_observables
  accepts_nested_attributes_for :goal_observables, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true
end
