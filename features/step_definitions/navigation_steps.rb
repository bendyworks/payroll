Given(/^I'm logged in$/) do
  @user = create :user
  visit new_user_session_path
  fill_in 'Email', with: @user.email
  fill_in 'Password', with: 'password'
  click_on 'Log in'
end

Given(/^I'm on the experience chart page$/) do
  visit experience_path
end
