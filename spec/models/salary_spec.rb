require 'rails_helper'

describe Salary do
  it { should belong_to :employee }
  it { should validate_presence_of :start_date }
  it { should validate_presence_of :annual_amount }
  it { should validate_presence_of :employee_id }

  describe 'validation no_salaries_outside_employment_dates' do
    let(:employee) do
      build(:employee).tap do |employee|
        employee.tenures = [build(:tenure, end_date: Time.zone.today + 5)]
        employee.save
      end
    end

    it 'allows salary starting on employee start date' do
      salary = employee.salaries.create(start_date: employee.start_date, annual_amount: 5)
      expect(salary).to be_valid
    end

    it 'allows salary starting on employee end date' do
      salary = employee.salaries.create(start_date: employee.end_date, annual_amount: 5)
      expect(salary).to be_valid
    end

    it 'prevents salary before employee start date' do
      salary = employee.salaries.create(start_date: employee.start_date - 1, annual_amount: 5)
      expect(salary).to be_invalid
    end

    it 'prevents salary after employee end date' do
      salary = employee.salaries.create(start_date: employee.end_date + 1, annual_amount: 5)
      expect(salary).to be_invalid
    end
  end
end
