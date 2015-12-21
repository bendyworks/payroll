require 'rails_helper'

describe SalariesController do
  include Devise::TestHelpers

  let(:user) { create :user }
  before { sign_in user }

  describe 'GET new' do
    let(:employee) { create :employee }

    it 'returns http success' do
      get :new, employee_id: employee.to_param
      expect(response).to have_http_status(:success)
    end

    it 'assigns a new salary as @salary' do
      get :new, employee_id: employee.to_param
      expect(assigns(:salary)).to be_a_new(Salary)
    end
  end

  describe 'POST create' do
    let(:employee) { create :employee }
    let(:post_params) { { employee_id: employee.to_param, salary: salary_params } }

    describe 'with valid params' do
      let(:salary_params) do
        { start_date: employee.start_date + 60, annual_amount: employee.starting_salary + 5000 }
      end

      it 'creates a new Salary' do
        expect do
          post :create, post_params
        end.to change(Salary, :count).by(1)
      end

      it 'assigns a newly created salary as @salary' do
        post :create, post_params
        expect(assigns(:salary)).to be_a(Salary)
        expect(assigns(:salary)).to be_persisted
      end
    end

    describe 'with invalid params' do
      let(:salary_params) do
        { start_date: employee.start_date - 7, annual_amount: employee.starting_salary + 5000 }
      end

      it 'assigns a newly created but unsaved salary as @salary' do
        post :create, post_params
        expect(assigns(:salary)).to be_a_new(Salary)
      end

      it "re-renders the 'new' template" do
        post :create, post_params
        expect(response).to render_template('new')
      end
    end
  end

  describe 'DELETE destroy' do
    let!(:salary) { create :salary }

    it 'deletes the selected salary' do
      expect do
        delete :destroy, employee_id: salary.employee.to_param, id: salary.to_param
      end.to change(Salary, :count).by(-1)
      expect { salary.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
