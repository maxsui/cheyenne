class SessionCustomer < ApplicationRecord
  belongs_to :session
  belongs_to :customer

  def project
    customer.projects.by_date(session.date) if customer
  end
end
