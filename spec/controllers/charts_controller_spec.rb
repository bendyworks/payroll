# frozen_string_literal: true

require 'rails_helper'

describe ChartsController do
  include Devise::Test::ControllerHelpers

  let(:user) { create :user }
  before { sign_in user }

  describe 'GET #home' do
    it 'returns http success' do
      get :home
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET salaries' do
    let!(:current_employee)  do
      build(:employee).tap do |employee|
        employee.tenures = [build(:tenure, end_date: Time.zone.today + 1)]
        employee.save
      end
    end
    let!(:salary_1) { create :salary, employee: current_employee }
    let!(:former_employee) do
      build(:employee).tap do |employee|
        employee.tenures = [build(:tenure, end_date: Time.zone.today - 1)]
        employee.save
      end
    end
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
