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

  describe 'PATCH update' do
    let!(:salary) { create :salary }
    let!(:employee) { salary.employee }

    context 'updating employee start date' do
      let(:employee_params) {  employee.attributes.merge('start_date' => Date.today) }
      let(:update_params) { { id: employee.id, employee: employee_params } }

      it 'updates starting salary start_date to match' do
        patch :update, update_params
        salary.reload

        expect(salary.start_date).to eq Date.today
      end
    end
  end

end
