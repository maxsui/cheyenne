class SessionCustomer < ApplicationRecord
  belongs_to :session
  belongs_to :customer
end
