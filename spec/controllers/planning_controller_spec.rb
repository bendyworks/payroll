# frozen_string_literal: true
require 'rails_helper'

RSpec.describe PlanningController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { create :user }
  before { sign_in user }

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
