class Observable < ApplicationRecord
  has_many :goal_observables, dependent: :destroy, inverse_of: :observable
  accepts_nested_attributes_for :goal_observables, reject_if: :all_blank, allow_destroy: true

  has_many :goals, through: :goal_observables

  validates :name, presence: true
end
