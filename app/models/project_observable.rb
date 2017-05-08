class ProjectObservable < ApplicationRecord
  belongs_to :project
  belongs_to :observable

  scope :active, -> { where ignored: [nil, false] }

  def toogle!
    update ignored: !ignored?
  end

end
