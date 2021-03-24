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
    let!(:current_employee) { create(:employee, end_date: Time.zone.today + 1) }
    let!(:former_employee) { create(:employee, end_date: Time.zone.today - 1) }

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
