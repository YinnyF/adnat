require 'rails_helper'

RSpec.feature "User Log Out", type: :feature do
  scenario "successful log out" do
    log_in
    click_link 'Log Out'

    expect(page).to have_content("Signed out successfully.")
  end

end