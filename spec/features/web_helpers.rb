def log_in
  User.create(name: 'Test Name', email: 'test@test.com', password: '123456')
  visit root_path
  fill_in 'Email', with: 'test@test.com'
  fill_in 'Password', with: '123456'
  click_button 'Log in'
end

def join_organisation
  Organisation.create(name: 'Test Org Name', hourly_rate: 10.00)
  visit root_path
  click_link 'Join'
end

def create_shift(day, month, year, s_hour, s_mins, f_hour, f_mins, break_length = 0)
  select day, :from => 'shift_date_3i'
  select month, :from => 'shift_date_2i'
  select year, :from => 'shift_date_1i'
  select s_hour, :from => 'shift_start_4i'
  select s_mins, :from => 'shift_start_5i'
  select f_hour, :from => 'shift_finish_4i'
  select f_mins, :from => 'shift_finish_5i'
  fill_in 'shift_break_length', with: break_length
  click_button 'Create Shift'
end
