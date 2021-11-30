require 'rails_helper'

RSpec.describe Shift, type: :model do
  let(:user) { User.create(name: "Test", email: "test@test.com", password: "123456") }
  let(:start_time) { DateTime.new(2021, 01, 01, 9, 0) }
  let(:finish_time) { DateTime.new(2021, 01, 01, 10, 0) }
  let(:shift) { described_class.new(start: start_time, finish: finish_time, break_length: 0, user_id: user.id) }

  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:start) }

  it { is_expected.to validate_presence_of(:finish) }

  it { is_expected.to validate_presence_of(:break_length) }

  it "creates a valid shift object" do
    expect(shift).to be_valid
  end

  it "does not accept invalid finish times" do
    # TODO: review for overnight shifts that is currently in the controller (this check will never happen)
    shift.finish = DateTime.new(2021, 01, 01, 8, 0)

    expect(shift).not_to be_valid
  end

  it "accepts valid break lengths" do
    shift.finish = DateTime.new(2021, 01, 01, 17, 0)
    shift.break_length = 60

    expect(shift).to be_valid
  end

  it "does not accept invalid break lengths" do
    shift.finish = DateTime.new(2021, 01, 01, 11, 0)
    shift.break_length = 121

    expect(shift).not_to be_valid
  end

  it "does not accept break lengths above 720mins/12hrs" do
    shift.finish = DateTime.new(2021, 01, 01, 22, 0)
    shift.break_length = 720
    expect(shift).to be_valid

    shift.break_length = 721
    expect(shift).not_to be_valid
  end

  it "does not accept negative break lengths" do
    shift.break_length = 0
    expect(shift).to be_valid

    shift.break_length = -1
    expect(shift).not_to be_valid
  end

  it "can retrieve the employee name" do
    expect(shift.employee_name).to eq "Test"
  end

  it "can retrieve the date in string format %d/%m/%Y" do
    expect(shift.shift_date).to eq "01/01/2021"
  end

  it "can retrieve the start time in string format %I:%M %p" do
    expect(shift.start_time).to eq "09:00 AM"
  end

  it "can retrieve the finish time in string format %I:%M %p" do
    expect(shift.finish_time).to eq "10:00 AM"
  end

  it "can calculate the hours worked to 2 D.P." do
    # 9am to 10am
    expect(shift.hours_worked).to eq "1.00"
  end

  it "can calculate the hours worked with a break" do
    # 9am to 10am with 30 min break
    shift.break_length = 30

    expect(shift.hours_worked).to eq "0.50"
  end

  context "#costs" do
    before do
      organisation = Organisation.create(name: "Test Org", hourly_rate: 10.00)
      Membership.create(user_id: user.id, organisation_id: organisation.id)
    end
    
    let(:start_time) { DateTime.new(2021, 01, 01, 9, 0) }
    let(:finish_time) { DateTime.new(2021, 01, 01, 10, 0) }
    let(:shift) { described_class.new(start: start_time, finish: finish_time, break_length: 0, user_id: user.id) }

    it "can calculate the cost based on the org hourly rate" do
      expect(shift.cost).to eq "10.00"
    end
    
    it "can calculate with a break" do
      shift.break_length = 30

      expect(shift.cost).to eq "5.00"
    end

    it "can calculate an overnight shift" do
      shift.finish = DateTime.new(2021, 01, 02, 9, 0)

      expect(shift.cost).to eq "240.00"
    end

    it "can calculate a sunday (2x) shift" do
      shift.start = DateTime.new(2021, 11, 28, 9, 0)
      shift.finish = DateTime.new(2021, 11, 28, 17, 0)
      shift.break_length = 60

      expect(shift.cost).to eq "140.00"
    end

    it "can calculate a sunday (2x) overnight shift" do
      shift.start = DateTime.new(2021, 11, 28, 22, 0)
      shift.finish = DateTime.new(2021, 11, 29, 2, 0)

      expect(shift.cost).to eq "60.00"
    end

    it "can calculate a sunday (2x) overnight shift with break - example 1" do
      shift.start = DateTime.new(2021, 11, 28, 22, 0)
      shift.finish = DateTime.new(2021, 11, 29, 3, 0)
      shift.break_length = 60

      expect(shift.cost).to eq "60.00"
    end

    it "can calculate a sunday (2x) overnight shift with break - example 2" do
      shift.start = DateTime.new(2021, 11, 28, 17, 0)
      shift.finish = DateTime.new(2021, 11, 29, 2, 0)
      shift.break_length = 120

      expect(shift.cost).to eq "140.00"
    end

    it "can calculate a sunday (2x) overnight shift with break - example 3" do
      shift.start = DateTime.new(2021, 11, 28, 21, 0)
      shift.finish = DateTime.new(2021, 11, 29, 1, 0)
      shift.break_length = 120

      expect(shift.cost).to eq "40.00"
    end

    it "can calculate a saturday overnight shift" do
      shift.start = DateTime.new(2021, 11, 27, 22, 0)
      shift.finish = DateTime.new(2021, 11, 28, 1, 0)

      expect(shift.cost).to eq "40.00"
    end

    it "can calculate a saturday overnight shift - with break" do
      shift.start = DateTime.new(2021, 11, 27, 22, 0)
      shift.finish = DateTime.new(2021, 11, 28, 2, 0)
      shift.break_length = 60

      expect(shift.cost).to eq "40.00"
    end

  end

end
