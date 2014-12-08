feature 'add employee' do
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
    click_button 'Create'

    expect(page).to have_content 'Newest Bendyworker'
    expect(page).to have_content 'successfully created'
  end
end
