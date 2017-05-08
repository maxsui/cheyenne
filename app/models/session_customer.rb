class SessionCustomer < ApplicationRecord
  belongs_to :session
  belongs_to :customer
  belongs_to :project

  has_many :observables, class_name: 'SessionCustomerObservable'

  before_validation :associate_project
  before_validation :complete_observables

  private

  def associate_project
    self.project = customer.projects.by_date(session.date).first if customer
  end

  def complete_observables
    return unless project

    observables.where.not(project: project).delete_all
    project.project_observables.active.each do |project_observable|
      observables.find_or_initialize_by(project_observable: project_observable)
    end
  end


end
