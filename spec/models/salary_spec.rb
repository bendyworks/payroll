# frozen_string_literal: true

require 'rails_helper'

describe Salary do
  it { should belong_to :tenure }
  it { should validate_presence_of :start_date }
  it { should validate_presence_of :annual_amount }
  it { should validate_presence_of :tenure }

  let(:employee) do
    build(:employee).tap do |employee|
      employee.tenures = [build(:tenure)]
      employee.save
    end
  end
  it 'validates employee salary start dates unique' do
    # actually instantiate the salary record so matcher has something to go by
    salary = employee.tenures.first.salaries.create(start_date: employee.start_date, annual_amount: 5)
    should validate_uniqueness_of(:start_date).scoped_to(:tenure_id)
  end

  describe 'ordered_dates' do
    let(:fourth_date) { 4.months.ago.to_date }
    let(:first_date) { 7.months.ago.to_date }
    let(:third_date) { 5.months.ago.to_date }
    let(:second_date) { 6.months.ago.to_date }
    let(:tenure) { create :tenure, start_date: first_date }

    let!(:first_added_salary) { create :salary, tenure: tenure, start_date: fourth_date }
    let!(:second_added_salary) { create :salary, tenure: tenure, start_date: first_date }
    let!(:third_added_salary) { create :salary, tenure: tenure, start_date: third_date }
    let!(:fourth_added_salary) { create :salary, tenure: tenure, start_date: second_date }

    it 'returns all salary dates in order' do
      expect(Salary.ordered_dates).to eq([first_date, second_date, third_date, fourth_date])
    end

    it 'removes duplicate dates' do
      create :salary, start_date: third_date
      expect(Salary.ordered_dates).to eq([first_date, second_date, third_date, fourth_date])
    end

    describe 'with_previous_dates' do
      it 'returns an array of dates, including each interesting date and the day before it' do
        expect(Salary.ordered_dates_with_previous_dates).to eq([first_date,
                                                                second_date - 1, second_date,
                                                                third_date - 1, third_date,
                                                                fourth_date - 1, fourth_date])
      end
    end
  end

  describe 'history_dates' do
    let(:first_start_date) { Time.zone.today - 14 }
    let(:second_start_date) { Time.zone.today - 7 }
    let(:first_end_date) { Time.zone.today - 5 }
    let(:second_end_date) { Time.zone.today + 7 }
    let(:first_salary_date) { Time.zone.today - 2 }
    let(:second_salary_date) { Time.zone.today + 2 }


    let!(:first_employee) do
      build(:employee).tap do |employee|
        employee.tenures = [build(:tenure, start_date: first_start_date, end_date: first_end_date)]
        employee.save
      end
    end
    let!(:second_employee) do
      build(:employee).tap do |employee|
        employee.tenures = [build(:tenure, start_date: first_start_date, end_date: second_end_date)]
        employee.save
      end
    end
    let!(:third_employee) do
      build(:employee).tap do |employee|
        employee.tenures = [build(:tenure, start_date: second_start_date)]
        employee.save
      end
    end

    let!(:first_added_salary) { create :salary, employee: second_employee, start_date: first_salary_date }
    let!(:second_added_salary) { create :salary, employee: third_employee, start_date: second_salary_date }

    it 'returns an ordered list of history dates' do
      expect(Salary.history_dates).to eq([first_start_date, second_start_date,
                                          first_end_date, first_end_date + 1,
                                          first_salary_date - 1, first_salary_date,
                                          second_salary_date - 1, second_salary_date,
                                          second_end_date, second_end_date + 1])
    end

  end

  describe 'validation no_salaries_outside_employment_dates' do
    let(:employee) do
      build(:employee).tap do |employee|
        employee.tenures = [build(:tenure, end_date: Time.zone.today + 5)]
        employee.save
      end
    end

    it 'allows salary starting on employee start date' do
      salary = employee.tenures.first.salaries.create(start_date: employee.start_date, annual_amount: 5)
      expect(salary).to be_valid
    end

    it 'allows salary starting on employee end date' do
      salary = employee.tenures.first.salaries.create(start_date: employee.end_date, annual_amount: 5)
      expect(salary).to be_valid
    end

    it 'prevents salary before employee start date' do
      salary = employee.tenures.first.salaries.create(start_date: employee.start_date - 1, annual_amount: 5)
      expect(salary).to be_invalid
    end

    it 'prevents salary after employee end date' do
      salary = employee.salaries.create(start_date: employee.end_date + 1, annual_amount: 5)
      expect(salary).to be_invalid
    end
  end

  describe 'before_validation' do
    let(:employee) do
      build(:employee).tap do |employee|
        employee.tenures = [build(:tenure, start_date: Time.zone.today - 5)]
        employee.save
      end
    end

    it 'should retrieve start date from related tenure if blank and first' do
      salary = employee.tenures.first.salaries.create(annual_amount: 5)
      expect(salary).to be_valid
    end

    it 'should be invalid if blank and second' do
      salary = employee.salaries.create(annual_amount: 5)
      salary2 = employee.salaries.create(annual_amount: 5)
      expect(salary2).to be_invalid
    end
  end

end
