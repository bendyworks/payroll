class ChartsController < ApplicationController
  def history
    opts = { width: 400, height: 240, title: 'Salary History', legend: 'bottom' }
    @chart = GoogleVisualr::Interactive::LineChart.new(history_chart_data, opts)
  end

  private

  def history_chart_data
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('date', 'Date')

    create_employee_columns data_table
    data_table.add_rows(Salary.ordered_dates.count)
    populate_salary_history_chart_data data_table
    data_table
  end

  def create_employee_columns data_table
    Employee.all.each do |employee|
      data_table.new_column('number', employee.first_name)
    end
  end

  def populate_salary_history_chart_data data_table
    Salary.ordered_dates.each_with_index do |date, date_row_num|
      Employee.all.each do |employee, employee_column_num|
        data_table.set_cell(date_row_num, employee_column_num, employee.salary_on(date))
      end
    end
  end
end
