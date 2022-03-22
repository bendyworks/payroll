require "rails_helper"

describe "Users" do
  context "A signed in admin" do
    before :each do
      sign_in_admin
    end

    it "invites a user" do
      visit users_path

      click_on "Invite new user"

      test_email = Faker::Internet.email
      fill_in 'user_email', with: test_email
      click_submit

      expect(page).to have_selector 'p.notice', text: 'An invitation email has been sent to ' + test_email + '.'
    end

    it "deletes a user" do
      @user_to_delete = create :user
      
      visit users_path

      find('a[href="/users/' + @user_to_delete.id.to_s + '"][data-method="delete"]').click

      expect(page).to have_selector 'p.notice', text: 'User deleted.'
    end

    it "updates admin status for user" do
      @user_to_update = create :user
      
      visit users_path
      find('tr#user_' + @user_to_update.id.to_s + ' input.admin_checkbox').click
      expect(page.find('tr#user_' + @user_to_update.id.to_s + ' input.admin_checkbox')).to be_checked
    end

    it "updates admin status for admin" do
      @admin_to_update = create :admin
      
      visit users_path
      find('tr#user_' + @admin_to_update.id.to_s + ' input.admin_checkbox').click
      expect(page.find('tr#user_' + @admin_to_update.id.to_s + ' input.admin_checkbox')).not_to be_checked
    end
  end

  context "A signed in (non-admin)user" do
    before :each do
      sign_in_user
    end

    it "attempts to invite a user" do
      visit users_path

      expect(find_link('Invite new user')[:disabled]).to eq 'disabled'
    end

    it "deletes a user" do
      @user_to_delete = create :user
      
      visit users_path

      expect(find('a[href="/users/' + @user_to_delete.id.to_s + '"][data-method="delete"]')[:disabled]).to eq 'disabled'
    end

    it "updates admin status for user" do
      @user_to_update = create :user
      
      visit users_path
      expect(find('tr#user_' + @user_to_update.id.to_s + ' input.admin_checkbox')[:disabled]).to eq 'disabled'
    end
  end
end