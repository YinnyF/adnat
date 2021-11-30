require 'rails_helper'

RSpec.feature "User Log In", type: :feature do
  background do
    visit root_path
    User.create(name: 'Test Name', email: 'test@test.com', password: '123456')
  end

  scenario "valid log in information" do
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'

    expect(page).to have_content("Signed in successfully.")
  end

  scenario "invalid log in information - wrong password" do
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: 'wrongpassword'
    click_button 'Log in'

    expect(page).to have_content("Invalid Email or password.")
  end

  scenario "invalid log in information - email doesn't exist" do
    fill_in 'Email', with: 'nope@nope.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'

    expect(page).to have_content("Invalid Email or password.")
  end

end
