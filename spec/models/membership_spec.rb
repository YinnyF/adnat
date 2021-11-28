require 'rails_helper'

RSpec.describe Membership, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:organisation) }

  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:organisation) }

  # xit "has one membership(organisation) per user" do
  #   # # TODO how to make this test work with doubles?
  #   # user = instance_double(User, id: 1)
  #   # user_2 = instance_double(User, id: 2)
  #   # org_1 = instance_double(Organisation, id: 1)
  #   # org_2 = instance_double(Organisation, id: 2)

  #   # membership = described_class.new(organisation_id: org_1.id, user_id: user.id)
  #   # p membership.save
  #   # p dupe_membership = described_class.new(organisation_id: org_2.id, user_id: user_2.id)
  #   # expect(dupe_membership).not_to be_valid
  # end
end
