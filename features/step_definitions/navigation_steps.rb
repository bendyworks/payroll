# frozen_string_literal: true
Given(/^I'm logged in$/) do
  @user = create :user
  visit new_user_session_path
  fill_in 'Email', with: @user.email
  fill_in 'Password', with: 'password'
  click_on 'Log in'
  sleep 1
  expect(page.current_path).not_to eq(new_user_session_path)
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

Then(/^I should be on the salaries page$/) do
  sleep 1
  expect(current_path).to eq salaries_path
end

Then(/^I should be on the experience page$/) do
  sleep 1
  expect(current_path).to eq experience_path
end

Then(/^I should be on employee's page$/) do
  sleep 1
  expect(current_path).to eq employee_path(@employee)
end

private

def log_in_if_necessary
  step "I'm logged in" unless @logged_in
end

PATH_MAP = {
  'balances chart' => 'balances',
  'experience chart' => 'experience',
  'planning' => 'planning',
  'salaries chart' => 'salaries',
  'users' => 'users'
}.freeze

def path_for(page_name)
  route_helper_prefix = PATH_MAP[page_name] || fail("#{page_name} page not recognized")
  Rails.application.routes.url_helpers.send("#{route_helper_prefix}_path")
end
