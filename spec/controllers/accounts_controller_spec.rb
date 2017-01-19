# frozen_string_literal: true
require 'rails_helper'

RSpec.describe AccountsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { create :user }
  before { sign_in user }

  let(:valid_attributes) { { name: 'Account Name' } }
  let(:invalid_attributes) { { name: nil } }

  describe 'GET #show' do
    it 'assigns the requested account as @account' do
      account = Account.create! valid_attributes
      get :show, id: account.to_param
      expect(assigns(:account)).to eq(account)
    end
  end

  describe 'GET #new' do
    it 'assigns a new account as @account' do
      get :new, {}
      expect(assigns(:account)).to be_a_new(Account)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested account as @account' do
      account = Account.create! valid_attributes
      get :edit, id: account.to_param
      expect(assigns(:account)).to eq(account)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Account' do
        expect do
          post :create, account: valid_attributes
        end.to change(Account, :count).by(1)
      end

      it 'assigns a newly created account as @account' do
        post :create, account: valid_attributes
        expect(assigns(:account)).to be_a(Account)
        expect(assigns(:account)).to be_persisted
      end

      it 'redirects to the created account' do
        post :create, account: valid_attributes
        expect(response).to redirect_to(Account.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved account as @account' do
        post :create, account: invalid_attributes
        expect(assigns(:account)).to be_a_new(Account)
      end

      it "re-renders the 'new' template" do
        post :create, account: invalid_attributes
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { name: 'New Account Name' } }

      it 'updates the requested account' do
        account = Account.create! valid_attributes
        put :update, id: account.to_param, account: new_attributes
        account.reload
        expect(account.name).to eq('New Account Name')
      end

      it 'assigns the requested account as @account' do
        account = Account.create! valid_attributes
        put :update, id: account.to_param, account: valid_attributes
        expect(assigns(:account)).to eq(account)
      end

      it 'redirects to the account' do
        account = Account.create! valid_attributes
        put :update, id: account.to_param, account: valid_attributes
        expect(response).to redirect_to(account)
      end
    end

    context 'with invalid params' do
      it 'assigns the account as @account' do
        account = Account.create! valid_attributes
        put :update, id: account.to_param, account: invalid_attributes
        expect(assigns(:account)).to eq(account)
      end

      it "re-renders the 'edit' template" do
        account = Account.create! valid_attributes
        put :update, id: account.to_param, account: invalid_attributes
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested account' do
      account = Account.create! valid_attributes
      expect do
        delete :destroy, id: account.to_param
      end.to change(Account, :count).by(-1)
    end

    it 'redirects to the home page' do
      account = Account.create! valid_attributes
      delete :destroy, id: account.to_param
      expect(response).to redirect_to(root_url)
    end
  end
end
