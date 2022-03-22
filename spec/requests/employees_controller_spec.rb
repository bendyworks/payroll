require 'rails_helper'

describe "Employee" do
  before :each do
    sign_in_admin
  end
  
  describe "An admin edits an employee" do
    before :each do
      @employee = create :employee
      create :tenure, employee: @employee
    end

    it "and records a raise, then deletes it." do
      visit employee_path @employee
      click_on "Record a Raise"

      @raise_amount = Faker::Number.decimal(l_digits: 6, r_digits: 2)
      fill_in "Start date", with: Faker::Date.between(from: 2.days.ago, to: Date.today)
      fill_in "Annual amount", with: @raise_amount
      click_submit

      expect(page).to have_css("#salary-listing td", text: view_helper.number_to_currency(@raise_amount, precision: 0))

      count_of_salaries = page.all("#salary-listing tr").count
      find("#salary-listing tr[2] a[rel='nofollow']").click

      expect(page).to have_css("#salary-listing tr", count: (count_of_salaries - 1))
    end

    it "updates personal information." do
      visit employee_path @employee
      click_on "Edit"

      fill_in "First name", with: Faker::Lorem.characters(number: 20, min_alpha: 3)
      fill_in "Last name", with: Faker::Lorem.characters(number: 20, min_alpha: 3)
      fill_in "Start date", with: Faker::Date.between(from: '2014-09-23', to: Date.today)
      fill_in "End date", with: Faker::Date.between(from: '2022-03-17', to: Date.today + 365)
      fill_in "Direct experience (months)", with: Faker::Number.between(from: 1, to: 20000)
      fill_in "Indirect experience (months)", with: Faker::Number.between(from: 1, to: 20000)
      fill_in "Starting salary annual amount", with: Faker::Number.decimal(l_digits: 6, r_digits: 2)
      fill_in "Notes", with: Faker::Lorem.characters(number: 50, min_alpha: 3)

      click_submit

      expect(page).to have_css("p.notice", text: "Employee successfully updated.")
    end
  end
end
