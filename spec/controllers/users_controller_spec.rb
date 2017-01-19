require 'rails_helper'

describe UsersController do
  include Devise::Test::ControllerHelpers

  let(:user) { create :user }
  before { sign_in user }

  describe 'GET index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'assigns all users as @users' do
      get :index
      expect(assigns(:users)).to eq User.all
    end
  end
end
