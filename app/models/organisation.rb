class Organisation < ApplicationRecord
  has_many :memberships
  has_many :users, :through => :memberships

  validates :name, presence: true, uniqueness: true
  validates :hourly_rate, presence: true
end
