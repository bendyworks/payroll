Given(/^I'm logged in$/) do
  @user = create :user
  visit new_user_session_path
  fill_in 'Email', with: @user.email
  fill_in 'Password', with: 'password'
  click_on 'Log in'
  @logged_in = true
end

When(/^I'm on the (.*) page$/) do |page_name|
  log_in_if_necessary
  visit path_for(page_name)
end

When(/^I'm on the homepage$/) do
  log_in_if_necessary
  visit root_path
end

When(/^I'm on that employee page$/) do
  log_in_if_necessary
  visit employee_path(@employee)
end

private

def log_in_if_necessary
  step "I'm logged in" unless @logged_in
end

def path_for page_name
  case page_name
  when 'balances chart'
    balances_path
  when 'experience chart'
    experience_path
  when 'salaries chart'
    salaries_path
  when 'users'
    users_path
  else
    raise "page #{page_name} not recognized"
  end
end
