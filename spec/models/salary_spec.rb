require 'rails_helper'

RSpec.describe Salary, :type => :model do
  it { should belong_to(:employee).dependent(:destroy) }
  it { should validate_presence_of :start_date }
  it { should validate_presence_of :annual_amount }
  it { should validate_presence_of :employee_id }

  it 'validates employee salary start dates unique' do
    create :salary
    should validate_uniqueness_of(:start_date).scoped_to(:employee_id)
  end

  describe 'ordered_dates' do
    let(:fourth_date) { Date.parse('2013-7-10') }
    let(:first_date) { Date.parse('2013-4-10') }
    let(:third_date) { Date.parse('2013-6-10') }
    let(:second_date) { Date.parse('2013-5-10') }

    let!(:first_added_salary) { create :salary, start_date: fourth_date }
    let!(:second_added_salary) { create :salary, start_date: first_date }
    let!(:third_added_salary) { create :salary, start_date: third_date }
    let!(:fourth_added_salary) { create :salary, start_date: second_date }

    it 'returns all salary dates in order' do
      expect(Salary.ordered_dates).to eq([first_date, second_date, third_date, fourth_date])
    end

    it 'removes duplicate dates' do
      create :salary, start_date: third_date

      expect(Salary.ordered_dates).to eq([first_date, second_date, third_date, fourth_date])
    end

    describe 'with_previous_dates' do
      it 'returns an array of dates, including each interesting date and the day before it' do
        expect(Salary.ordered_dates_with_previous_dates).to eq([first_date - 1, first_date,
                                                                second_date - 1, second_date,
                                                                third_date - 1, third_date,
                                                                fourth_date - 1, fourth_date])
      end
    end
  end

  describe 'validation no_salaries_outside_employment_dates' do
    let(:employee) { create :employee, end_date: Date.today + 5 }

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
