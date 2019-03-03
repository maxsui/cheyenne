class SeanceCustomer < ApplicationRecord
  belongs_to :seance
  belongs_to :customer
  belongs_to :project, optional: true
  belongs_to :group, optional: true

  has_many :observables, class_name: 'SeanceCustomerObservable', dependent: :destroy

  before_validation :associate_default_project

  validates :customer, uniqueness: { scope: :seance }

  scope :by_period, ->(range) { joins(:seance).where("seances.begin": range) }

  def associate_project(project)
    return if self.project == project

    self.project = project
    complete_observables
  end

  def notes
    @notes ||= compute_notes
  end

  def compute_notes
    rows = observables.noted.joins(:goals).group("goals.id").average(:note).map do |goal_id, note|
      [goal_id, note]
    end
    Hash[rows]
  end

  private

  def associate_default_project
    return unless customer

    default_project = customer.projects.by_date(seance.date).first
    associate_project default_project
  end

  def complete_observables
    return unless project

    observables.joins(:goals).where.not("goals.id": project).delete_all
    project.project_observables.active.each do |project_observable|
      observables.find_or_initialize_by(project_observable: project_observable)
    end
  end

end
