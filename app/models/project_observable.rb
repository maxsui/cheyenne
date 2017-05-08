class ProjectObservable < ApplicationRecord
  belongs_to :project
  belongs_to :observable

  def toogle!
    update ignored: !ignored?
  end

end
