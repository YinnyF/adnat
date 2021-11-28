class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :organisation
  
  validates :organisation, :user, presence: true
  validates :user, uniqueness: { message: "You already belong to an organisation" }
end
