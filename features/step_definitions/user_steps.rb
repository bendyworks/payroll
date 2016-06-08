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
