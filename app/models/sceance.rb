class Sceance < ApplicationRecord
  has_many :sceance_customers
  accepts_nested_attributes_for :sceance_customers, reject_if: :all_blank, allow_destroy: true

  has_many :customers, through: :sceance_customers

  has_many :sceance_users
  accepts_nested_attributes_for :sceance_users, reject_if: :all_blank, allow_destroy: true

  has_many :users, through: :sceance_users

  validates :begin, presence: true
  validates :end, presence: true

  validates :sceance_customers, presence: true
  validates :sceance_users, presence: true

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
end
