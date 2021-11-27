class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :organisation
  
  validates :organisation, :user, presence: true
end
