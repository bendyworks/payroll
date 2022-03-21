require 'rails_helper'

describe "Planning" do
  before :each do
    sign_in_admin
  end
  describe "Planning Listing" do
    it "has the right amount of rows." do
      visit planning_path
      
      expect(page).to have_selector('#planning tbody tr', count: Employee.current.count)
    end
  end
end
