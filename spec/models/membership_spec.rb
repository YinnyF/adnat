require 'rails_helper'

RSpec.describe Membership, type: :model do
  let(:user) { User.create(name: "Test", email: "test@test.com", password: "123456") }
  let(:organisation_1) { Organisation.create(name: "Test Org 1", hourly_rate: 12.00 ) }
  let(:organisation_2) { Organisation.create(name: "Test Org 2", hourly_rate: 12.00 ) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:organisation) }

  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:organisation) }

  it "valid membership(organisation) for user" do
    # TODO how to make this test work with doubles instead (isolation)?
    membership = described_class.new(user_id: user.id, organisation_id: organisation_1.id)
    
    expect(membership).to be_valid
  end

  it "invalid membership(organisation) for user - duplicate org" do
    # TODO how to make this test work with doubles instead (isolation)?
    membership_1 = described_class.new(user_id: user.id, organisation_id: organisation_1.id)
    membership_1.save

    membership_2 = described_class.new(user_id: user.id, organisation_id: organisation_2.id)

    expect(membership_1).to be_valid
    expect(membership_2).not_to be_valid
  end
end
