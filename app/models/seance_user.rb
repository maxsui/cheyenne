class SeanceUser < ApplicationRecord
  belongs_to :seance
  belongs_to :user
end
