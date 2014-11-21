require 'rails_helper'

RSpec.describe ChartsController, :type => :controller do
  include Devise::TestHelpers

  let(:user) { create :user }
  before do
    sign_in user
  end

  describe "GET history" do
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
