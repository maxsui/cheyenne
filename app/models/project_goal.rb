class ProjectGoal < ApplicationRecord
  belongs_to :project, optional: true
  belongs_to :goal
end
