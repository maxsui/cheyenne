class SeanceCustomer < ApplicationRecord
  belongs_to :seance
  belongs_to :customer
  belongs_to :project, optional: true
  belongs_to :group, optional: true

  has_many :observables, class_name: 'SeanceCustomerObservable'

  before_validation :associate_project
  before_validation :complete_observables

  validates :customer, uniqueness: { scope: :seance }

  private

  def associate_project
    self.project = customer.projects.by_date(seance.date).first if customer
  end

  def complete_observables
    return unless project


    observables.joins(:goals).where.not("goals.id": project).delete_all
    project.project_observables.active.each do |project_observable|
      observables.find_or_initialize_by(project_observable: project_observable)
    end
  end

end