# frozen_string_literal: true

Then(/^the experience chart is present$/) do
  within '.body' do
    expect(page).to have_content('Experience')
  end
  within '#experience_chart' do
    expect(page).to have_css('.recharts-responsive-container')
  end
end

Then(/^the salaries chart is present$/) do
  within '.body' do
    expect(page).to have_content('Salaries')
  end
  within '#salaries_chart' do
    expect(page).to have_content(6.months.ago.year.to_s)
  end
end

Then(/^their salary history chart is present$/) do
  within '.body' do
    expect(page).to have_content('Salary History')
  end
  within '#salary_chart' do
    expect(page).to have_content(6.months.ago.year.to_s)
  end
end

Then(/^the balances chart is present$/) do
  within '.body' do
    expect(page).to have_content('Balances')
  end
  within '#balances_chart' do
    expect(page).to have_content('City Bank')
  end
end

Then(/^current employment status is checked$/) do
  current_checkbox = find('#employment_current')
  expect(current_checkbox).to be_checked
end

When('I apply {string} only') do |string|
  %w(Current Past Billable Support).each do |checkbox|
    box = find_field(checkbox)
    box.click if box.checked?
  end

  find_field(string).click
  click_button 'Apply'
end

Then('I should not see George and Frida') do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^a small salary history chart is present$/) do
  within '.body' do
    expect(page).to have_content('Salaries')
  end
  expect(page).to have_css('#salaries_chart')
end

Then(/^a small experience chart is present$/) do
  within '.body' do
    expect(page).to have_content('Experience')
  end
  expect(page).to have_css('#experience_chart')
end

When(/^I click on the small salary history chart$/) do
  find('#salaries_chart').click
end

When(/^I click on the small experience chart$/) do
  find('#experience_chart').click
end
