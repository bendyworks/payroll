require "rails_helper"

def click_submit
    find('input[name="commit"]').click
end

def sign_in_admin
    @admin_user = create :admin
    
    visit new_user_session_path

    fill_in 'user_email', with: @admin_user.email
    fill_in 'user_password', with: @admin_user.password
    click_submit

    expect(page).to have_selector 'p.notice', text: 'Signed in successfully.'
end

def sign_in_user
    @user = create :user
    
    visit new_user_session_path

    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    click_submit

    expect(page).to have_selector 'p.notice', text: 'Signed in successfully.'
end