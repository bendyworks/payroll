require 'rails_helper'

describe "Charts" do
  before :each do
    sign_in_admin
  end
  describe "Charts/Home Page" do
    it "has the right amount of charts displayed." do
      visit root_path
      
      expect(page).to have_selector('#salaries_chart')
      expect(page).to have_selector('#experience_chart')
    end
  end
end
