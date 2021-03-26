# frozen_string_literal: true

feature 'manage salaries' do
  let(:user) { create :user }
  let(:employee) { create :employee }

  before do
    visit '/users/sign_in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  scenario 'add new employee salary' do
    visit "/employees/#{employee.id}"
    click_on 'Record a Raise'
    fill_in 'Start date', with: Time.zone.today
    fill_in 'Annual amount', with: 44_000
    click_button 'Save'

    expect(page).to have_content '$44,000'
    expect(page).to have_content 'Successfully recorded raise'
  end

  context 'Raise salary exists' do
    let!(:salary) { create :salary, tenure: employee.tenures.first, start_date: employee.tenures.first.start_date + 30 }
    let(:link) { "a[href$=\"/salaries/#{salary.id}\"]" }

    scenario 'delete salary' do
      visit "/employees/#{salary.employee.id}"
      find(:css, link).click

      expect(page).to have_content 'Salary deleted'
    end
  end
end
