require 'rails_helper'

RSpec.feature "Calculate shift cost", type: :feature do
  background do
    log_in
    join_organisation
    click_link 'View Shifts'
  end

  scenario "a shift with no break" do
    create_shift('07', '02', '2019', '10', '15', '13', '30')

    expect(page).to have_content("Shift was successfully created.")
    expect(page).to have_content("07/02/2019")
    expect(page).to have_content("10:15 AM")
    expect(page).to have_content("01:30 PM")
    expect(page).to have_content("3.25")
    # rate of the org is $10.00
    expect(page).to have_content("$32.50")
  end

  scenario "a shift with a break" do
    create_shift('07', '02', '2019', '10', '15', '13', '30', '60')

    expect(page).to have_content("Shift was successfully created.")
    expect(page).to have_content("07/02/2019")
    expect(page).to have_content("10:15 AM")
    expect(page).to have_content("01:30 PM")
    expect(page).to have_content("2.25")
    # rate of the org is $10.00
    expect(page).to have_content("$22.50")
  end

  scenario "an overnight shift" do
    create_shift('07', '02', '2019', '22', '00', '02', '00', '60')

    expect(page).to have_content("Shift was successfully created.")
    expect(page).to have_content("07/02/2019")
    expect(page).to have_content("10:00 PM")
    expect(page).to have_content("02:00 AM")
    expect(page).to have_content("3.00")
    # rate of the org is $10.00
    expect(page).to have_content("$30.00")
  end

  scenario "a sunday shift (2x)" do
    create_shift('28', '11', '2021', '09', '00', '17', '00', '60')

    expect(page).to have_content("Shift was successfully created.")
    expect(page).to have_content("28/11/2021")
    expect(page).to have_content("09:00 AM")
    expect(page).to have_content("05:00 PM")
    expect(page).to have_content("7.00")
    # rate of the org is $10.00
    expect(page).to have_content("$140.00")
  end

  scenario "a sunday (2x) overnight shift" do
    create_shift('28', '11', '2021', '22', '00', '02', '00')

    expect(page).to have_content("Shift was successfully created.")
    expect(page).to have_content("28/11/2021")
    expect(page).to have_content("10:00 PM")
    expect(page).to have_content("02:00 AM")
    expect(page).to have_content("4.00")
    # rate of the org is $10.00
    expect(page).to have_content("$60.00")
  end

  scenario "a sunday (2x) overnight shift with break - example 1" do
    create_shift('28', '11', '2021', '22', '00', '03', '00', '60')

    expect(page).to have_content("Shift was successfully created.")
    expect(page).to have_content("28/11/2021")
    expect(page).to have_content("10:00 PM")
    expect(page).to have_content("03:00 AM")
    expect(page).to have_content("4.00")
    # rate of the org is $10.00
    expect(page).to have_content("$60.00")
  end

  scenario "a sunday (2x) overnight shift with break - example 2" do
    create_shift('28', '11', '2021', '17', '00', '02', '00', '120')

    expect(page).to have_content("Shift was successfully created.")
    expect(page).to have_content("28/11/2021")
    expect(page).to have_content("05:00 PM")
    expect(page).to have_content("02:00 AM")
    expect(page).to have_content("7.00")
    # rate of the org is $10.00
    expect(page).to have_content("$140.00")
  end

  scenario "a sunday (2x) overnight shift with break - example 3" do
    create_shift('28', '11', '2021', '21', '00', '01', '00', '120')

    expect(page).to have_content("Shift was successfully created.")
    expect(page).to have_content("28/11/2021")
    expect(page).to have_content("09:00 PM")
    expect(page).to have_content("01:00 AM")
    expect(page).to have_content("2.00")
    # rate of the org is $10.00
    expect(page).to have_content("$40.00")
  end

  scenario "a saturday overnight shift" do
    create_shift('27', '11', '2021', '22', '00', '01', '00')

    expect(page).to have_content("Shift was successfully created.")
    expect(page).to have_content("27/11/2021")
    expect(page).to have_content("10:00 PM")
    expect(page).to have_content("01:00 AM")
    expect(page).to have_content("3.00")
    # rate of the org is $10.00
    expect(page).to have_content("$40.00")
  end

  scenario "a saturday overnight shift - with break" do
    create_shift('27', '11', '2021', '22', '00', '02', '00', '60')

    expect(page).to have_content("Shift was successfully created.")
    expect(page).to have_content("27/11/2021")
    expect(page).to have_content("10:00 PM")
    expect(page).to have_content("02:00 AM")
    expect(page).to have_content("3.00")
    # rate of the org is $10.00
    expect(page).to have_content("$40.00")
  end
end