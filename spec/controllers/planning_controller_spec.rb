# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PlanningController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { create :user }
  before { sign_in user }

  describe 'GET #index' do
    let!(:current_employee) { create :employee }
    let!(:leaving_employee) do
      build(:employee).tap do |employee|
        employee.tenures = [build(:tenure, end_date: Time.zone.today + 1)]
        employee.save
      end
    end
    let!(:ex_employee) do
      build(:employee).tap do |employee|
        employee.tenures = [build(:tenure, end_date: Time.zone.today - 1)]
        employee.save
      end
    end
    let!(:future_employee) do
      build(:employee).tap do |employee|
        employee.tenures = [build(:tenure, start_date: Time.zone.today + 10)]
        employee.save
      end
    end

    it 'shows only current employees' do
      get :index
      expect(assigns[:employees]).to eq([current_employee, leaving_employee])
    end
  end
end
