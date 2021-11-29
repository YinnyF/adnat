require 'rails_helper'

RSpec.feature "User edit shifts", type: :feature do
  background do
    log_in
    join_organisation
    click_link 'View Shifts'
  end

  scenario "can edit a shift" do
    create_shift('07', '02', '2019', '10', '15', '13', '30')
    expect(page).to have_content("Shift was successfully created.")

    find(:xpath, "//tr[td[contains(.,'07/02/2019')]]/td/a", :text => 'Edit').click
    select '15', :from => 'shift_finish_4i'
    fill_in 'shift_break_length', with: '30'

    click_button 'Update Shift'
    expect(page).to have_content("Shift was successfully updated.")
    click_link 'Back'
    expect(page).to have_content("3:30 PM")
  end

end