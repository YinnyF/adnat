class Organisation < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, :through => :memberships

  validates :name, presence: true, uniqueness: true
  validates :hourly_rate, presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: { greater_than: 0, less_than: 1000 }
end
