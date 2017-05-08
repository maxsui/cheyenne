class Session < ApplicationRecord
  has_many :session_customers
  accepts_nested_attributes_for :session_customers, reject_if: :all_blank, allow_destroy: true

  has_many :customers, through: :session_customers

  has_many :session_users
  accepts_nested_attributes_for :session_users, reject_if: :all_blank, allow_destroy: true

  has_many :users, through: :session_users

  validates :begin, presence: true
  validates :end, presence: true

  validates :session_customers, presence: true
  validates :session_users, presence: true

  def self.by_date(date)
    time = date.to_time
    where(begin: (time.beginning_of_day)..(time.end_of_day))
  end

  def duration
    self.end - self.begin
  end

  def date
    self.begin.to_date
  end
end
