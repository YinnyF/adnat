require 'rails_helper'

RSpec.describe Organisation, type: :model do
  let(:organisation) { described_class.new(name: 'Test Name', hourly_rate: 11.00) }

  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to validate_presence_of(:hourly_rate) }

  it "has unique organisation names" do
    organisation.save
    duplicate_org = described_class.new(name: 'Test Name', hourly_rate: 11.00)
    expect(duplicate_org).not_to be_valid
  end

  it "creates a valid organisation object" do
    expect(organisation).to be_valid
    expect(organisation.name).to eq 'Test Name'
    expect(organisation.hourly_rate).to eq 11.00
  end

  it "should accept valid hourly rates" do
    valid_rates = [11.00, 11, 0.01, 999.99, "11", "11.11"]

    valid_rates.each do |valid_rate|
      organisation.hourly_rate = valid_rate
      expect(organisation).to be_valid
    end
  end

  it "shouldn't accept invalid hourly rates" do
    invalid_rates = [0.001, "notarate"]

    invalid_rates.each do |invalid_rate|
      organisation.hourly_rate = invalid_rate
      expect(organisation).not_to be_valid
    end
  end

end
