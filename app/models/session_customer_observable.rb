class SessionCustomerObservable < ApplicationRecord
  belongs_to :session_customer
  belongs_to :project_observable
  belongs_to :user, optional: true

  scope :noted, ->() { where.not note: nil }

  def observable
    project_observable.try :observable
  end

  def ignored?
    note == -1
  end
end
