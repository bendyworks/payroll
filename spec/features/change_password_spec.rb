feature 'change password' do
  let(:user) { create :user }
  before do
    visit '/users/sign_in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  scenario 'change password' do
    visit '/users/edit'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'new password'
    fill_in 'Password confirmation', with: 'new password'
    fill_in 'Current password', with: user.password
    click_button 'Update'

    expect(page).to have_content 'updated successfully'
  end
end
