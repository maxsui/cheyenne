class SceanceCustomerObservable < ApplicationRecord
  belongs_to :sceance_customer
  belongs_to :project_observable
  belongs_to :user, optional: true
  has_one :observable, through: :project_observable
  has_many :goals, through: :observable

  scope :evaluated, ->() { where.not note: nil }
  scope :noted, ->() { where "note >= 0" }

  def ignored?
    note == -1
  end
end
