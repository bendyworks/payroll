# frozen_string_literal: true

feature 'Authorization' do
  context 'not logged in' do
    scenario 'visit to root is redirected to login page' do
      visit '/'
      expect(current_path).to eq '/users/sign_in'
      expect(page).to have_content 'need to sign in'
    end
  end

  scenario 'logs in' do
    user = create :user

    visit '/users/sign_in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect(current_path).to eq '/'
    expect(page).to have_content 'Sign Out'
  end
end
