Then(/^the experience chart is present$/) do
  expect(page).to have_content('Industry Experience vs Current Salary')
  within '#experience_chart' do
    expect(page).to have_content('Experience vs Salary')
  end
end
