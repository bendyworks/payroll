feature 'manage employee' do
  let(:user) { create :user }
  before do
    visit '/users/sign_in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  scenario 'add new employee' do
    visit '/employees/new'
    fill_in 'First name', with: 'Newest'
    fill_in 'Last name', with: 'Bendyworker'
    fill_in 'Start date', with: Date.today
    fill_in 'Direct experience', with: 5
    fill_in 'Starting salary', with: 40000
    click_button 'Save'

    expect(page).to have_content 'Newest Bendyworker'
    expect(page).to have_content 'successfully created'
  end

  context 'employee exists' do
    let(:employee) { create :employee }
    let!(:salary) { create :salary, employee: employee }

    scenario 'edit employee basic info' do
      visit "/employees/#{employee.id}"
      click_on 'Edit'
      fill_in 'First name', with: 'Different'
      fill_in 'Indirect experience', with: 11
      click_button 'Save'

      expect(page).to have_content "Different #{employee.last_name}"
      expect(page).to have_content '11 months indirect'
    end

    scenario 'edit employee salary info' do
      visit "/employees/#{employee.id}"
      click_on 'Edit'
      fill_in 'Starting salary', with: 41000
      click_button 'Save'

      expect(page).to have_content '$41,000'
    end
  end
end
