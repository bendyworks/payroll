Then(/^the experience chart is present$/) do
  expect(page).to have_content('Industry Experience vs Current Salary')
  within '#experience_chart' do
    expect(page).to have_content('Experience vs Salary')
  end
end

Then(/^the salary history chart is present$/) do
  expect(page).to have_content('Salary History')
  within '#history_chart' do
    expect(page).to have_content('Salary Rate ($ annually)')
  end
end

Then(/^their salary history chart is present$/) do
  expect(page).to have_content("Salary History Chart")
  within '#history_chart' do
    expect(page).to have_content('Salary Rate ($ annually)')
  end
end
