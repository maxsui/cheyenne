class Session < ApplicationRecord
  has_many :session_customers
  accepts_nested_attributes_for :session_customers, reject_if: :all_blank, allow_destroy: true

  has_many :customers, through: :session_customers

  def self.by_date(date)
    time = date.to_time
    where(begin: (time.beginning_of_day)..(time.end_of_day))
  end

  def duration
    self.end - self.begin
  end
end
