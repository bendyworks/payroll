Then(/^the experience chart is present$/) do
  within '.body' do
    expect(page).to have_content('Experience')
  end
  within '#experience_chart' do
    expect(page).to have_content('Years at Bendyworks plus partial prior experience')
  end
end

Then(/^the salaries chart is present$/) do
  within '.body' do
    expect(page).to have_content('Salaries')
  end
  within '#salaries_chart' do
    expect(page).to have_content('2015')
  end
end

Then(/^their salary history chart is present$/) do
  within '.body' do
    expect(page).to have_content('Salary History')
  end
  within '#salary_chart' do
    expect(page).to have_content('2015')
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
  expect(page).to have_css('#experience_preview_chart')
end
