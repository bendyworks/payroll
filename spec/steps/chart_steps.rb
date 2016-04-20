step "the experience chart is present" do
  within '.body' do
    expect(page).to have_content('Experience')
  end
  within '#experience_chart' do
    expect(page).to have_content('Years at Bendyworks plus partial prior experience')
  end
end

step "the salaries chart is present" do
  within '.body' do
    expect(page).to have_content('Salaries')
  end
  within '#salaries_chart' do
    expect(page).to have_content('2015')
  end
end

step "their salary history chart is present" do
  within '.body' do
    expect(page).to have_content('Salary History')
  end
  within '#salary_chart' do
    expect(page).to have_content('2015')
  end
end

step "the balances chart is present" do
  within '.body' do
    expect(page).to have_content('Balances')
  end
  within '#balances_chart' do
    expect(page).to have_content('City Bank')
  end
end

step "current employment status is checked" do
  current_checkbox = find('#employment_current')
  expect(current_checkbox).to be_checked
end
