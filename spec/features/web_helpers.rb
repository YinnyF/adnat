def log_in
  User.create(name: 'Test Name', email: 'test@test.com', password: '123456')
  visit root_path
  fill_in 'Email', with: 'test@test.com'
  fill_in 'Password', with: '123456'
  click_button 'Log in'
end