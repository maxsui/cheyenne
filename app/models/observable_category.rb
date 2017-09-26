class ObservableCategory < ApplicationRecord
  has_many :observables, -> { order(:name) }

  validates :name, presence: true
end
