Given(/^I'm logged in$/) do
  @user = create :user
  visit new_user_session_path
  fill_in 'Email', with: @user.email
  fill_in 'Password', with: 'password'
  click_on 'Log in'
  @logged_in = true
end

When(/^I'm on the homepage$/) do
  log_in_if_necessary
  visit root_path
end

Given(/^I'm on the experience chart page$/) do
  log_in_if_necessary
  visit experience_path
end

When(/^I'm on the salaries chart page$/) do
  log_in_if_necessary
  visit salaries_path
end

When(/^I'm on that employee page$/) do
  log_in_if_necessary
  visit employee_path(@employee)
end

Then(/^I'm on the balances chart page$/) do
  log_in_if_necessary
  visit balances_path
end

When(/^I'm on the users page$/) do
  log_in_if_necessary
  visit users_path
end

private

def log_in_if_necessary
  step "I'm logged in" unless @logged_in
end
