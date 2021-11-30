require 'rails_helper'

RSpec.feature "User Organisations", type: :feature do
  background do
    Organisation.create(name: org_name, hourly_rate: 10.00)
    log_in
  end

  let(:org_name) { 'Name 1' }

  scenario "user without an org is prompted to join/create an org" do
    expect(page).to have_content("You aren't a member of any organisations.")
    expect(page).to have_content("Join an existing one or create a new one.")
    expect(page).to have_content("Create organisation")
  end

  scenario "user without an org can edit an existing organisation" do
    expect(page).to have_content("#{org_name}")
    click_link 'Edit'
    new_org_name = 'Name Changed'
    new_org_rate = 11.00
    fill_in 'organisation[name]', with: "#{new_org_name}"
    fill_in 'organisation[hourly_rate]', with: new_org_rate
    click_button 'Update'

    expect(page).to have_content("Organisation was successfully updated.")
    expect(page).to have_content("#{new_org_name}")
  end

  scenario "user without an org can create an organisation and automatically join it" do
    new_org_name = 'Name 3'
    new_org_rate = 12.00
    fill_in 'organisation[name]', with: "#{new_org_name}"
    fill_in 'organisation[hourly_rate]', with: new_org_rate
    click_button 'Create and Join'

    expect(page).to have_content("Organisation was successfully created.")
    expect(page).to have_link("View Shifts")
    expect(page).not_to have_content("You aren't a member of any organisations.")
  end

  scenario "user without an org can join an existing organisation" do
    click_link("Join", :match => :first)

    expect(page).to have_content("Joined #{org_name}")
  end

  scenario "user can leave an organisation" do
    click_link("Join", :match => :first)
    expect(page).to have_content("#{org_name}")
    click_link("Leave")

    expect(page).to have_content("Successfully left the organisation.")
    expect(page).to have_content("You aren't a member of any organisations.")
    expect(page).to have_content("Join an existing one or create a new one.")
  end

end
