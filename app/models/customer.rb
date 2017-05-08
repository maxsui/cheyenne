class Customer < ApplicationRecord
  validates :name, presence: true

  has_many :projects, -> { order 'begin desc' }
end
