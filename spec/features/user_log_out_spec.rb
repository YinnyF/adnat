require 'rails_helper'

RSpec.feature "User Log Out", type: :feature do
  background do
    User.create(name: 'Test Name', email: 'test@test.com', password: '123456')
    visit root_path
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'
  end

  scenario "successful log out" do
    click_link 'Log out'

    expect(page).to have_content("Signed out successfully.")
  end

end