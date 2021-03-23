# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SalaryGraph do
  describe '#to_table' do
    context 'an empty set of employees' do
      it 'returns an empty table of data' do
        existing_date = Date.new(2030, 12, 12)
        employees = []

        table = SalaryGraph.new(employees, [existing_date]).to_table
        expect(table).to eq([{ date: existing_date }])
      end
    end

    context 'with a single employees' do
      it 'returns a properly formatted set of data' do
        first_existing_date = Date.new(2030, 12, 12)
        expected_first_salary = 130_000

        second_existing_date = Date.new(2035, 0o2, 10)
        expected_second_salary = 150_000

        employee = create(:employee, starting_salary: expected_first_salary)
        employee.salaries.create(start_date: second_existing_date - 1.day,
                                 annual_amount: expected_second_salary)

        table = SalaryGraph.new([employee], [first_existing_date, second_existing_date]).to_table

        first_expected_hash = { :date => first_existing_date,
                                employee.id => { name: employee.display_name,
                                                 salary: employee.salary_on(first_existing_date) } }
        second_expected_hash = { :date => second_existing_date,
                                 employee.id => { name: employee.display_name,
                                                  salary: employee.salary_on(second_existing_date) } }

        expect(table).to eq([first_expected_hash, second_expected_hash])
      end
    end
  end
end
