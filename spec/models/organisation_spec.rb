require 'rails_helper'

RSpec.describe Organisation, type: :model do
  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to validate_presence_of(:hourly_rate) }

  it "has unique organisation names" do
    organisation = described_class.new(name: 'Test Name', hourly_rate: 11.00)
    organisation.save
    duplicate_org = described_class.new(name: 'Test Name', hourly_rate: 11.00)
    expect(duplicate_org).not_to be_valid
  end

  

end
