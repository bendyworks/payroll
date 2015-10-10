require 'rails_helper'

describe EmployeesController do
  include Devise::TestHelpers

  let(:user) { create :user }
  before { sign_in user }

  describe "GET show" do
    let!(:employee) { create :employee }

    it "returns http success" do
      get :show, id: employee.id
      expect(response).to have_http_status(:success)
    end

    it 'assigns the requested employee as @employee' do
      get :edit, id: employee.to_param
      expect(assigns(:employee)).to eq(employee)
    end
  end

  describe 'GET edit' do
    let!(:employee) { create :employee }

    it "returns http success" do
      get :edit, id: employee.id
      expect(response).to have_http_status(:success)
    end

    it 'assigns the requested employee as @employee' do
      get :edit, id: employee.to_param
      expect(assigns(:employee)).to eq(employee)
    end
  end

  describe 'GET new' do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'assigns a new employee as @employee' do
      get :new, {}
      expect(assigns(:employee)).to be_a_new(Employee)
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new Employee' do
        expect do
          post :create, employee: attributes_for(:employee)
        end.to change(Employee, :count).by(1)
      end

      it 'assigns a newly created employee as @employee' do
        post :create, employee: attributes_for(:employee)
        expect(assigns(:employee)).to be_a(Employee)
        expect(assigns(:employee)).to be_persisted
      end
    end

    describe 'with invalid params' do
      let(:invalid_attributes) { attributes_for(:employee).merge(start_date: nil) }

      it 'assigns a newly created but unsaved employee as @employee' do
        post :create, employee: invalid_attributes
        expect(assigns(:employee)).to be_a_new(Employee)
      end

      it "re-renders the 'new' template" do
        post :create, employee: invalid_attributes
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT update' do
    let!(:employee) { create :employee }
    let(:attributes) { attributes_for(:employee).merge(new_attributes) }

    describe 'with valid params' do
      let(:new_attributes) { { last_name: 'Another' } }

      it 'updates the requested employee' do
        put :update, id: employee.to_param, employee: attributes
        employee.reload

        expect(employee.last_name).to eql 'Another'
      end

      it 'assigns the requested employee as @employee' do
        put :update, id: employee.to_param, employee: attributes
        expect(assigns(:employee)).to eq(employee)
      end

      it 'redirects to the employee show page' do
        put :update, id: employee.to_param, employee: attributes
        expect(response).to redirect_to(employee_path(employee))
      end
    end

    describe 'with invalid params' do
      let(:new_attributes) { { last_name: nil } }

      it 'assigns the employee as @employee' do
        put :update, id: employee.to_param, employee: attributes
        expect(assigns(:employee)).to eq(employee)
      end

      it "re-renders the 'edit' template" do
        put :update, id: employee.to_param, employee: attributes
        expect(response).to render_template('edit')
      end
    end
  end

end
