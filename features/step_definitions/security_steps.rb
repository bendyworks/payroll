Then(/^I cannot go directly to the users page$/) do
  visit users_path
  expect(current_path).to eq(root_path)
  # alert_message = %p.alert.alert-danger= alert
  # expect(alert_message).to eq("Access Denied")
end
