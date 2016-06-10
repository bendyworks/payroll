Given(/^an admin user$/) do
  @admin = create :admin
end

Given(/^a non\-admin user$/) do
  @user = create :user
end

Then(/^the admin user should have admin checked$/) do
  within "#user_#{@admin.id}" do
    admin_checkbox = find('.admin_checkbox')
    expect(admin_checkbox).to be_checked
  end
end

Then(/^the non\-admin user should not have admin checked$/) do
  within "#user_#{@user.id}" do
    admin_checkbox = find('.admin_checkbox')
    expect(admin_checkbox).not_to be_checked
  end
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

When(/^I check the admin button for that user$/) do
  within "#user_#{@user.id}" do
    admin_checkbox = find('.admin_checkbox')
    admin_checkbox.set true
  end
end

Then(/^that user should have admin checked$/) do
  within "#user_#{@user.id}" do
    admin_checkbox = find('.admin_checkbox')
    expect(admin_checkbox).to be_checked
  end
end

Then(/^that user should be an admin$/) do
  expect(@user.reload.admin).to be true
end

When(/^I uncheck the admin button for that user$/) do
  within "#user_#{@user.id}" do
    admin_checkbox = find('.admin_checkbox')
    admin_checkbox.set false
  end
end

Then(/^that user should not have admin checked$/) do
  within "#user_#{@user.id}" do
    admin_checkbox = find('.admin_checkbox')
    expect(admin_checkbox).not_to be_checked
  end
end

Then(/^that user should not be an admin$/) do
  expect(@user.reload.admin).to be false
end
