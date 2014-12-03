require 'rails_helper'

RSpec.describe EmployeesController, :type => :controller do
  include Devise::TestHelpers

  let(:user) { create :user }
  before do
    sign_in user
  end

  describe "GET show" do
    let!(:employee) { create :employee }

    it "returns http success" do
      get :show, id: employee.id
      expect(response).to have_http_status(:success)
    end
  end
end
