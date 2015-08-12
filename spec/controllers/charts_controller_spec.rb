require 'rails_helper'

describe ChartsController do
  include Devise::TestHelpers

  let(:user) { create :user }
  before do
    sign_in user
  end

  describe "GET history" do
    let!(:current_employee) { create :employee }
    let!(:salary_1) { create :salary, employee: current_employee }
    let!(:former_employee) { create :employee, end_date: Date.today - 2 }
    let!(:salary_2) { create :salary, employee: former_employee }

    it "returns http success" do
      get :history
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET experience" do
    it "returns http success" do
      get :experience
      expect(response).to have_http_status(:success)
    end
  end
end
