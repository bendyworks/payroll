require "rails_helper"

describe "Accounts" do
  context "A signed in user" do
    before :each do
      sign_in_user
    end

    it "creates an account" do
      visit new_account_path

      select 'Savings', from: 'account_account_type_id'
      fill_in 'account_name', with: 'Chuck Testa Banking'
      click_submit

      expect(page).to have_selector 'p.notice', text: 'Account was successfully created.'
      expect(page).to have_text 'Chuck Testa Banking'
    end

    it "updates account name" do
      @account = create :account
      
      visit edit_account_path @account
      fill_in 'account_name', with: 'Chuck Testa Banking'
      click_submit

      expect(page).to have_selector 'p.notice', text: 'Account was successfully updated.'
      expect(page).to have_text 'Chuck Testa Banking'
    end

    it "updates account type" do
      @account = create :account
      
      visit edit_account_path @account
      select 'Checking', from: 'account_account_type_id'
      click_submit

      expect(page).to have_selector 'p.notice', text: 'Account was successfully updated.'
      expect(page).to have_text 'Checking'
    end

    pending "deletes an account"
  end
end