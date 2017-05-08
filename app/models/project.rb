# coding: utf-8
class Project < ApplicationRecord
  belongs_to :customer

  has_many :project_goals
  accepts_nested_attributes_for :project_goals, reject_if: :all_blank, allow_destroy: true
  has_many :goals, through: :project_goals

  has_many :project_observables
  # accepts_nested_attributes_for :project_observables, reject_if: :all_blank, allow_destroy: true
  has_many :observables, through: :project_observables

  validates :begin, presence: true
  validates :end, presence: true

  validates :project_goals, presence: true
  validates :project_observables, presence: true

  validate :check_range_conflict

  scope :by_date, ->(date) { where("?::date <@ daterange(projects.begin, projects.end,'[]')", date) }
  scope :by_period, ->(range) { where("daterange(projects.begin, projects.end,'[]') && daterange(?, ?, '[]')", range.begin, range.end) }
  scope :by_customer, ->(customer) { where customer: customer }
  scope :inactive, -> { where.not("?::date <@ daterange(projects.begin, projects.end,'[]')", Date.today) }

  def self.current
    by_date(Date.today).first
  end

  before_validation :complete_observables

  def complete_observables
    Observable.by_goal(project_goals.map(&:goal_id)).each do |observable|
      project_observables.find_or_initialize_by(observable: observable)
    end
  end

  def other_projects_in_conflict
    self.class.by_period(Range.new(self.begin, self.end)).by_customer(customer)
  end

  private

  def check_range_conflict
    other_projects_in_conflict.each do |project|
      errors.add :begin, "Un autre projet couvre cette période pour ce client"
      errors.add :end, "Un autre projet couvre cette période pour ce client"
    end
  end

end
