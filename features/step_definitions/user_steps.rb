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