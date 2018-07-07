# coding: utf-8
class Project < ApplicationRecord
  belongs_to :customer

  has_many :project_goals, -> { joins(:goal).order('goals.name') }
  accepts_nested_attributes_for :project_goals, reject_if: :all_blank, allow_destroy: true
  has_many :goals, through: :project_goals

  has_many :project_observables, -> { joins(:observable).order('observables.name') }
  # accepts_nested_attributes_for :project_observables, reject_if: :all_blank, allow_destroy: true
  has_many :observables, through: :project_observables

  has_many :seance_customers, -> (project) { where(customer_id: project.customer_id) }
  has_many :seances, through: :seance_customers

  validates :begin, presence: true
  validates :end, presence: true

  validates :project_goals, presence: true
  validates :project_observables, presence: true

  validate :check_range_conflict

  def seance_observables
    SeanceCustomerObservable.joins(project_observable: :project).where("projects.id = ?", id)
  end

  scope :by_date, ->(date) { where("?::date <@ daterange(projects.begin, projects.end,'[]')", date) }
  scope :by_period, ->(range) { where("daterange(projects.begin, projects.end,'[]') && daterange(?, ?, '[]')", range.begin, range.end) }
  scope :by_customer, ->(customer) { where customer: customer }
  scope :inactive, -> { where.not("?::date <@ daterange(projects.begin, projects.end,'[]')", Date.today) }

  def self.current
    by_date(Date.today).first
  end

  before_validation :complete_observables

  def goal_ids
    project_goals.map(&:goal_id)
  end

  def complete_observables
    Observable.by_goal(goal_ids).distinct.each do |observable|
      project_observables.find_or_initialize_by(observable: observable)
    end
  end

  def other_projects_in_conflict
    scope = self.class.by_period(Range.new(self.begin, self.end)).by_customer(customer)
    scope = scope.where.not(id: id) if persisted?
    scope
  end

  def notes
    @notes ||= compute_notes
  end

  def compute_notes
    rows = seance_observables.noted.joins(:goals).where('goals.id' => goal_ids).group("goals.id").average(:note).map do |goal_id, note|
      [Goal.find(goal_id), note]
    end
    Hash[rows]
  end

  private

  def check_range_conflict
    other_projects_in_conflict.each do |project|
      errors.add :begin, "Un autre projet couvre cette période pour ce client"
      errors.add :end, "Un autre projet couvre cette période pour ce client"
    end
  end

end
