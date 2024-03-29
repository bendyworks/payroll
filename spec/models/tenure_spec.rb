require 'rails_helper'

describe Tenure do
  it { should belong_to :employee }
  it { should validate_presence_of :start_date }
  it { should validate_presence_of :employee }

  context 'unique start dates' do
    it 'validates employee tenure start dates unique' do
      create :tenure
      should validate_uniqueness_of(:start_date).scoped_to(:employee_id)
    end
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
end
