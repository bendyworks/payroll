require 'rails_helper'

describe ChartsController do
  include Devise::TestHelpers

  let(:user) { create :user }
  before { sign_in user }

  describe 'GET salaries' do
    let!(:current_employee) { create :employee, :current }
    let!(:salary_1) { create :salary, employee: current_employee }
    let!(:former_employee) { create :employee, :past }
    let!(:salary_2) { create :salary, employee: former_employee }

    it 'returns http success' do
      get :salaries
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET experience' do
    it 'returns http success' do
      get :experience
      expect(response).to have_http_status(:success)
    end
  end
end
