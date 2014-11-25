require 'rails_helper'

RSpec.describe ChartsController, :type => :controller do
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

    it 'assigns all employees when show_inactive = true' do
      get :history, show_inactive: 'true'
      expect(assigns(:history_employees)).to eq Employee.all
    end

    it 'assigns current employees when show_inactive != true' do
      get :history
      expect(assigns(:history_employees)).to eq Employee.current
    end
  end

  describe "GET experience" do
    it "returns http success" do
      get :experience
      expect(response).to have_http_status(:success)
    end

    it 'assigns all employees when show_inactive = true' do
      get :experience, show_inactive: 'true'
      expect(assigns(:experience_employees)).to eq Employee.all
    end

    it 'assigns current employees when show_inactive != true' do
      get :experience
      expect(assigns(:experience_employees)).to eq Employee.current
    end
  end
end
