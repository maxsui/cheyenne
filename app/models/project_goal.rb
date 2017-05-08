class ProjectGoal < ApplicationRecord
  belongs_to :project
  belongs_to :goal
end
