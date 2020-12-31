# frozen_string_literal: true

require 'rails_helper'

describe EmployeesController do
  include Devise::Test::ControllerHelpers

  let(:user) { create :user }
  before { sign_in user }

  describe 'GET show' do
    let!(:employee) { create :employee }

    it 'returns http success' do
      get :show, params: { id: employee.id }
      expect(response).to have_http_status(:success)
    end

    it 'assigns the requested employee as @employee' do
      get :edit, params: { id: employee.to_param }
      expect(assigns(:employee)).to eq(employee)
    end
  end

  describe 'GET edit' do
    let!(:employee) { create :employee }

    it 'returns http success' do
      get :edit, params: { id: employee.id }
      expect(response).to have_http_status(:success)
    end

    it 'assigns the requested employee as @employee' do
      get :edit, params: { id: employee.to_param }
      expect(assigns(:employee)).to eq(employee)
    end
  end

  describe 'GET new' do
    it 'returns http success' do
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
      let(:valid_attributes) {{ employee: attributes_for(:employee).merge(tenures_attributes: [{ start_date: Time.zone.today }]) }}
      it 'creates a new Employee' do
        expect do
          post :create, params: valid_attributes
        end.to change(Employee, :count).by(1)
      end

      it 'creates a new Employee with the expected start date' do
        post :create, params: valid_attributes
        expect(assigns(:employee).start_date).to eq(valid_attributes[:employee][:tenures_attributes][0][:start_date])
      end

      it 'assigns a newly created employee as @employee' do
        post :create, params: valid_attributes
        expect(assigns(:employee)).to be_a(Employee)
        expect(assigns(:employee)).to be_persisted
      end
    end

    describe 'with invalid params' do
      let(:invalid_attributes) {{ employee: attributes_for(:employee).merge(first_name: nil).merge(tenures_attributes: [{ start_date: Time.zone.today }]) }}

      it 'assigns a newly created but unsaved employee as @employee' do
        post :create, params: invalid_attributes
        expect(assigns(:employee)).to be_a_new(Employee)
      end

      it "re-renders the 'new' template" do
        post :create, params: invalid_attributes
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
        put :update, params: { id: employee.to_param, employee: attributes }
        employee.reload

        expect(employee.last_name).to eql 'Another'
      end

      it 'assigns the requested employee as @employee' do
        put :update, params: { id: employee.to_param, employee: attributes }
        expect(assigns(:employee)).to eq(employee)
      end

      it 'redirects to the employee show page' do
        put :update, params: { id: employee.to_param, employee: attributes }
        expect(response).to redirect_to(employee_path(employee))
      end
    end

    describe 'with invalid params' do
      let(:new_attributes) { { last_name: nil } }

      it 'assigns the employee as @employee' do
        put :update, params: { id: employee.to_param, employee: attributes }
        expect(assigns(:employee)).to eq(employee)
      end

      it "re-renders the 'edit' template" do
        put :update, params: { id: employee.to_param, employee: attributes }
        expect(response).to render_template('edit')
      end
    end
  end
end
