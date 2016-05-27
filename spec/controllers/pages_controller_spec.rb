require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  include Devise::TestHelpers

  let(:user) { create :user }
  before { sign_in user }

  describe 'GET #home' do
    it 'returns http success' do
      get :home
      expect(response).to have_http_status(:success)
    end
  end
end
