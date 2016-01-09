require 'rails_helper'
require 'filter_employees'

describe FilterEmployees do
  let(:chart) { (Class.new { include FilterEmployees }).new }
  subject { chart.filtered_collection(params).map(&:first_name) }

  context 'Filtering on employment status' do
    let!(:current) { create :employee, :current, first_name: 'Current' }
    let!(:past) { create :employee, :past, first_name: 'Past' }
    let!(:future) { create :employee, :future, first_name: 'Future' }

    context 'requesting only past employees' do
      let(:params) { { employment: { past: 1 } } }
      it { is_expected.to include('Past') }
      it { is_expected.not_to include('Current') }
      it { is_expected.not_to include('Future') }
    end

    context 'include only current employees' do
      let(:params) { { employment: { current: 1 } } }
      it { is_expected.not_to include('Past') }
      it { is_expected.to include('Current') }
      it { is_expected.not_to include('Future') }
    end

    context 'include only future employees' do
      let(:params) { { employment: { future: 1 } } }
      it { is_expected.not_to include('Past') }
      it { is_expected.not_to include('Current') }
      it { is_expected.to include('Future') }
    end

    context 'include both current and future' do
      let(:params) { { employment: { current: 1, future: 1 } } }
      it { is_expected.not_to include('Past') }
      it { is_expected.to include('Current') }
      it { is_expected.to include('Future') }
    end

    context 'include both past and current' do
      let(:params) { { employment: { past: 1, current: 1 } } }
      it { is_expected.to include('Past') }
      it { is_expected.to include('Current') }
      it { is_expected.not_to include('Future') }
    end

    context 'include all' do
      context 'all checked' do
        let(:params) { { employment: { past: 1, current: 1, future: 1 } } }
        it { is_expected.to include('Past') }
        it { is_expected.to include('Current') }
        it { is_expected.to include('Future') }
      end
      context 'none checked' do
        let(:params) { { employment: nil } }
        it { is_expected.to include('Past') }
        it { is_expected.to include('Current') }
        it { is_expected.to include('Future') }
      end
    end
  end

  context 'filtering on billable status' do
    let!(:billed) { create :employee, :billable, first_name: 'Billable' }
    let!(:support) { create :employee, :support, first_name: 'Support' }

    context 'include only billable' do
      let(:params) { { billable: { true: 1 } } }
      it { is_expected.to include('Billable') }
      it { is_expected.not_to include('Support') }
    end

    context 'include only support' do
      let(:params) { { billable: { false: 1 } } }
      it { is_expected.not_to include('Billable') }
      it { is_expected.to include('Support') }
    end

    context 'include all' do
      context 'all checked' do
        let(:params) { { billable: { true: 1, false: 1 } } }
        it { is_expected.to include('Billable') }
        it { is_expected.to include('Support') }
      end
      context 'none checked' do
        let(:params) { { billable: nil } }
        it { is_expected.to include('Billable') }
        it { is_expected.to include('Support') }
      end
    end
  end
end
