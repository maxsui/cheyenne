class ProjectObservable < ApplicationRecord
  belongs_to :project, optional: true
  belongs_to :observable

  scope :active, -> { where ignored: [nil, false] }

  def toogle!
    update ignored: !ignored?
  end
end
