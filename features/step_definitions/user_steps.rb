Given(/^an admin user exists$/) do
  create :user, admin: true
end

Given(/^a non\-admin user exists$/) do
  create :user, admin: false
end

Then(/^the admin user should have admin checked$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the non\-admin user should not have admin checked$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^user "(.*?)"$/) do |email|
  create :user, email: email
end

When(/^I delete user "([^"]*)"$/) do |user_email|
  user = User.find_by email: user_email
  within "#user_#{user.id}" do
    click_on 'Delete'
  end
end

Then(/^"([^"]*)" should no longer be a user in the database$/) do |user_email|
  user = User.find_by email: user_email
  expect(user).to be_nil
end