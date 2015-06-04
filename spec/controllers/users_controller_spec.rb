require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  include Devise::TestHelpers

  let(:user) { create :user }
  before do
    sign_in user
  end

  describe 'GET index' do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'assigns all users as @users' do
      get :index
      expect(assigns(:users)).to eq User.all
    end
  end
end
