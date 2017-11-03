class Group < ApplicationRecord
  has_many :group_memberships
  accepts_nested_attributes_for :group_memberships, reject_if: :all_blank, allow_destroy: true

  has_many :customers, through: :group_memberships
end
