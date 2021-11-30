require 'rails_helper'

RSpec.feature "User create shifts", type: :feature do
  background do
    log_in
    join_organisation
    click_link 'View Shifts'
  end

  scenario "can create a shift" do
    create_shift('07', '02', '2019', '10', '15', '13', '30')

    expect(page).to have_content("Shift was successfully created.")
    expect(page).to have_content("07/02/2019")
    expect(page).to have_content("10:15 AM")
    expect(page).to have_content("01:30 PM")
  end

  scenario "invalid shift - break length" do
    create_shift('07', '02', '2019', '10', '15', '13', '30', '210')

    expect(page).not_to have_content("Shift was successfully created.")
    expect(page).to have_content("Please check the break length")
  end

  scenario "valid shift - finish time earlier than start date is assumed to be overnight" do
    create_shift('07', '02', '2019', '10', '30', '09', '30')

    expect(page).to have_content("Shift was successfully created.")
    expect(page).to have_content("23.00")
  end

  scenario "shifts are destroyed when a user leaves an org" do
    create_shift('07', '02', '2019', '10', '15', '13', '30')
    visit root_path
    click_link 'Leave'
    click_link 'Join'
    click_link 'View Shifts'

    expect(page).not_to have_content("07/02/2019")
    expect(page).not_to have_content("10:15 AM")
    expect(page).not_to have_content("01:30 PM")
  end

end