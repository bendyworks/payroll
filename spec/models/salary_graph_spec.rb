# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SalaryGraph do
  describe '#to_table' do
    context 'an empty set of employees' do
      it 'returns an empty table of data' do
        existing_date = Date.new(2030,12,12)
        expected_date_format = existing_date.to_time.to_f * 1000
        employees = []

        table = SalaryGraph.new(employees, [existing_date]).to_table

        expect(table).to match_array([[expected_date_format]])
      end
    end

    context 'with a single employees' do
      it 'returns a properly formatted set of data' do
        first_existing_date = Date.new(2030,12,12)
        first_expected_date_format = first_existing_date.to_time.to_f * 1000
        expected_first_salary = 130_000

        second_existing_date = Date.new(2035,02,10)
        second_expected_date_format = second_existing_date.to_time.to_f * 1000
        expected_second_salary = 150_000

        employee = create(:employee)
        tenure = employee.tenures.first
        tenure.salaries.create(annual_amount: expected_first_salary)
        tenure.salaries.create(start_date: second_existing_date - 1.day, annual_amount: expected_second_salary)

        first_expected_tooltip = "#{first_existing_date}\n#{employee.display_name}: $130K"
        second_expected_tooltip = "#{second_existing_date}\n#{employee.display_name}: $150K"

        table = SalaryGraph.new([employee], [first_existing_date, second_existing_date]).to_table

        expect(table).to match_array([
          [first_expected_date_format, expected_first_salary, first_expected_tooltip],
           [second_expected_date_format, expected_second_salary, second_expected_tooltip]
          ])
      end
    end
  end
end
