# frozen_string_literal: true
require 'rails_helper'

RSpec.describe ChartsHelper, type: :helper do
  describe 'future_employee_exists?' do
    subject { future_employee_exists? }
    context 'with future employee' do
      before do
        create :employee, start_date: 1.week.from_now
      end

      it 'returns true' do
        expect(subject).to eq(true)
      end
    end
    context 'without future employee' do
      it 'returns false' do
        expect(subject).to eq(false)
      end
    end
  end
end
