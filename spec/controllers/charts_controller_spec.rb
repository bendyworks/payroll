require 'rails_helper'

RSpec.describe ChartsController, :type => :controller do

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
