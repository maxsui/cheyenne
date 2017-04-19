class GoalObservable < ApplicationRecord
  self.table_name = 'goals_observables'

  belongs_to :goal
  belongs_to :observable
end
