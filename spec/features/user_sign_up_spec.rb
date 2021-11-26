require 'rails_helper'

RSpec.feature "User Sign Up", type: :feature do
  background do
    visit new_user_registration_path
  end

  scenario "valid sign up information" do
    fill_in 'Name', with: 'Test Name'
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_button 'Sign up'

    expect(page).to have_content("Welcome! You have signed up successfully.")
  end

  scenario "invalid sign up information - password not matching" do
    fill_in 'Name', with: 'Test Name'
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: 'nomatchy'
    click_button 'Sign up'

    expect(page).to have_content("Password confirmation doesn't match Password")
  end

  scenario "invalid sign up information - email already exists" do
    User.create(name: 'Test Name', email: 'test@test.com', password: 'password')

    fill_in 'Name', with: 'Test Name'
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_button 'Sign up'

    expect(page).to have_content("Email has already been taken")
  end
end