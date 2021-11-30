require 'rails_helper'

RSpec.feature "User Edit Account", type: :feature do
  background do
    log_in
    click_link 'Edit details'
  end

  scenario "successful name change" do
    new_name = 'New Name'
    fill_in 'Name', with: new_name
    fill_in 'Current password', with: '123456'
    click_button 'Update'

    expect(page).to have_content("Logged in as #{new_name}")
  end

  scenario "successful email change" do
    fill_in 'Email', with: 'new@test.com'
    fill_in 'Current password', with: '123456'
    click_button 'Update'

    expect(page).to have_content("Your account has been updated successfully")
  end

  scenario "successful password change" do
    fill_in 'Password', with: 'newpassword'
    fill_in 'Password confirmation', with: 'newpassword'
    fill_in 'Current password', with: '123456'
    click_button 'Update'
    
    expect(page).to have_content("Your account has been updated successfully")
  end

  scenario "unsuccessful password change" do
    fill_in 'Password', with: 'newpassword'
    fill_in 'Password confirmation', with: 'nomatchy'
    fill_in 'Current password', with: '123456'
    click_button 'Update'
    
    expect(page).not_to have_content("Your account has been updated successfully")
    expect(page).to have_content("Password confirmation doesn't match Password")
  end

end