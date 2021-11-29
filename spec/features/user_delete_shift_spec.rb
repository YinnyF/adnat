require 'rails_helper'

RSpec.feature "User delete shift", type: :feature do
  background do
    log_in
    join_organisation
    click_link 'View Shifts'
  end

  scenario "can delete a shift" do
    create_shift('07', '02', '2019', '10', '15', '13', '30')
    expect(page).to have_content("Shift was successfully created.")

    find(:xpath, "//tr[td[contains(.,'07/02/2019')]]/td/a", :text => 'Delete').click

    expect(page).to have_content("Shift was successfully destroyed.")
    expect(page).not_to have_content("07/02/2019")
  end

end