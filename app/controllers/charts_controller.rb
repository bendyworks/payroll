class ChartsController < ApplicationController
  def history

  end

  private

  def history_chart_data
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('date', 'Date')

    create_employee_columns
    data_table.add_rows(interesting_dates.count)
    populate_salary_history_chart_data
  end

  def create_employee_columns
    Employee.all.each do |employee|
      data_table.new_column('number', employee.first_name)
    end
  end

  def populate_salary_history_chart_data
    interesting_dates.each_with_index do |date, date_row_num|
      Employee.all.each do |employee, employee_column_num|
        data_table.set_cell(date_row_num, employee_column_num, employee.salary_on(date))
      end
    end
  end
end
