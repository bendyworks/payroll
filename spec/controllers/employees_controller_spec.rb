require 'rails_helper'

RSpec.describe EmployeesController, :type => :controller do

  describe "GET show" do
    let!(:employee) { create :employee }

    it "returns http success" do
      get :show, id: employee.id
      expect(response).to have_http_status(:success)
    end
  end

end
