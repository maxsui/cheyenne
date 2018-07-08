class Customer < ApplicationRecord
  validates :name, presence: true

  has_many :projects, -> { order 'begin desc' }

  has_many :seance_customers
  has_many :seances, through: :seance_customers
end
