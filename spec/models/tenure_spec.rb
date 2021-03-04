# frozen_string_literal: true

require 'rails_helper'

describe Tenure do
  it { should belong_to :employee }
  it { should validate_presence_of :start_date }
  it { should validate_presence_of :employee }

  it 'validates employee tenure start dates unique' do
    create :tenure
    should validate_uniqueness_of(:start_date).scoped_to(:employee_id)
  end

  context 'end date is after start date' do
    let(:employee) do
      build(:employee).tap do |employee|
        employee.tenures = [build(:tenure, start_date: Time.zone.today, end_date: Time.zone.today - 2)]
        employee.save
      end
    end

    it 'validates start date is before end date' do
      tenure = employee.tenures.first
      expect(tenure).to be_invalid
    end
  end

  context 'overlapping tenures' do
    let(:employee) do
      build(:employee).tap do |employee|
        employee.tenures = [build(:tenure, start_date: Time.zone.today - 14, end_date: Time.zone.today - 7)]
        employee.save
      end
    end

    it 'validates tenure does not overlap with the previous tenure' do
      tenure = employee.tenures.create(start_date: Time.zone.today - 10)
      expect(tenure).to be_invalid
    end

    it 'validates tenure does not overlap with the next tenure' do
      employee.tenures.create(start_date: Time.zone.today - 5)
      tenure = employee.tenures.first
      tenure.end_date = Time.zone.today - 3
      expect(tenure).to be_invalid
    end
  end

  context 'ordered dates' do
    let(:first_start_date) { Time.zone.today - 14 }
    let(:second_start_date) { Time.zone.today - 7 }
    let(:first_end_date) { Time.zone.today - 3 }
    let(:second_end_date) { Time.zone.today + 7 }

    let!(:first_tenure) { create :tenure, start_date: first_start_date, end_date: first_end_date }
    let!(:second_tenure) { create :tenure, start_date: first_start_date, end_date: second_end_date }
    let!(:third_tenure) { create :tenure, start_date: second_start_date }

    it 'returns all start dates in order' do
      expect(Tenure.ordered_start_dates).to eq([first_start_date, second_start_date])
    end

    it 'returns all end dates in order with next dates' do
      expect(Tenure.ordered_end_dates_with_next_dates).to eq([first_end_date,
                                                              first_end_date + 1,
                                                              second_end_date,
                                                              second_end_date + 1])
    end
  end
end
