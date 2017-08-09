# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PlanningController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { create :user }
  before { sign_in user }

  describe 'GET #index' do
    let!(:current_employee) { create :employee }
    let!(:leaving_employee) { create :employee, :current }
    let!(:ex_employee) { create :employee, :past }
    let!(:future_employee) { create :employee, :future }

    it 'shows only current employees' do
      get :index
      expect(assigns[:employees]).to eq([current_employee, leaving_employee])
    end
  end
end
