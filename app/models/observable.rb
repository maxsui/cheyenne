class Observable < ApplicationRecord
  has_many :goal_observables, dependent: :destroy, inverse_of: :observable
  accepts_nested_attributes_for :goal_observables, reject_if: :all_blank, allow_destroy: true

  has_many :goals, through: :goal_observables

  validates :name, presence: true

  scope :by_goal, ->(goals) { joins(:goal_observables).where('goals_observables.goal_id in (?)', Array(goals).map { |g| g.respond_to?(:id) ? g.id : g } ) }

end
