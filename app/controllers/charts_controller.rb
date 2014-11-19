class ChartsController < ApplicationController
  def history
    opts = { width: 800, height: 500, title: 'Salary History', legend: 'bottom',
             vAxis: { title: 'Salary Rate ($ annually)' } }
    @chart = GoogleVisualr::Interactive::LineChart.new(history_chart_data, opts)
  end

  def experience
    opts = { width: 800, height: 500, title: 'Experience vs Salary',
             hAxis: { title: 'Years at Bendyworks', minValue: 0 },
             vAxis: { title: 'Current Salary' }, legend: 'none' }
    @chart = GoogleVisualr::Interactive::ScatterChart.new(experience_chart_data, opts)
  end

  private

  ##### History Chart methods ######

  def history_chart_data
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('date', 'Date')

    create_employee_columns data_table
    data_table.add_rows(Salary.ordered_dates_with_previous_dates.count)
    populate_salary_history_chart_data data_table
    data_table
  end

  def create_employee_columns data_table
    Employee.all.each do |employee|
      data_table.new_column('number', employee.first_name)
    end
  end

  def populate_salary_history_chart_data data_table
    Salary.ordered_dates_with_previous_dates.each_with_index do |date, date_row_num|
      data_table.set_cell(date_row_num, 0, date)

      Employee.all.each_with_index do |employee, employee_column_num|
        data_table.set_cell(date_row_num, employee_column_num + 1, employee.salary_on(date))
      end
    end
  end


  ##### Experience Chart methods ######

  def experience_chart_data
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('number', 'Years at Bendyworks')
    data_table.new_column('number', 'Current Salary')
    data_table.new_column('string', 'tooltip text', nil, 'tooltip')
    data_table.add_rows(Employee.count * 2)

    populate_experience_chart_data data_table
    data_table
  end

  def populate_experience_chart_data data_table
    Employee.all.each_with_index do |employee, employee_row_num|
      data_table.set_cell(employee_row_num, 0, employee.years_experience)
      data_table.set_cell(employee_row_num, 1, employee.salary_on(Date.today))
      data_table.set_cell(employee_row_num, 2, "#{employee.first_name}:\n#{employee.formatted_experience}\n\$#{employee.salary_on(Date.today)} salary")
    end
  end
end