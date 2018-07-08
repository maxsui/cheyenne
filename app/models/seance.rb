class Seance < ApplicationRecord
  has_many :seance_customers
  accepts_nested_attributes_for :seance_customers, reject_if: :all_blank, allow_destroy: true

  has_many :customers, through: :seance_customers

  has_many :seance_users
  accepts_nested_attributes_for :seance_users, reject_if: :all_blank, allow_destroy: true

  has_many :users, through: :seance_users

  has_many :seance_groups
  accepts_nested_attributes_for :seance_groups, reject_if: :all_blank, allow_destroy: true

  has_many :groups, through: :seance_groups

  validates :begin, presence: true
  validates :end, presence: true

  validate :check_no_customer
#  validates :seance_users, presence: true

  def check_no_customer
    if seance_customers.empty? and seance_groups.empty?
      errors.add :seance_customers, :empty
      errors.add :seance_groups, :empty
    end
  end

  scope :by_period, ->(range) { where(begin: range) }

  def self.by_date(date)
    time = date.to_time
    where(begin: (time.beginning_of_day)..(time.end_of_day))
  end

  def self.after(time)
    where(["begin > ?", time])
  end

  def self.before(time)
    where(['"end" < ?', time])
  end

  def duration
    self.end - self.begin
  end

  def date
    self.begin.to_date
  end

  def candidates
    @candidates ||= Candidate.create(self)
  end

  class Candidate

    attr_reader :customer

    def initialize(customer)
      @customer = customer
    end

    delegate :id, :name, to: :customer

    def groups
      @groups ||= []
    end

    def default_group
      groups.first unless groups.many?
    end

    def self.create(seance)
      candidates = {}

      seance.seance_groups.each do |seance_group|
        seance_group.group.customers.each do |customer|
          unless seance.customers.include? customer
            candidate = (candidates[customer.id] ||= Candidate.new(customer))
            candidate.groups << seance_group.group
          end
        end
      end

      candidates.values.sort_by(&:name)
    end

  end

end
