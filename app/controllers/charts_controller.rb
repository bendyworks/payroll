class ChartsController < ApplicationController
  def history
    show_inactive = (params[:show_inactive] == 'true')
    opts = { width: 800, height: 500, title: 'Salary History', legend: 'bottom',
             vAxis: { title: 'Salary Rate ($ annually)', minValue: 0 } }
    @chart = GoogleVisualr::Interactive::LineChart.new(history_chart_data(show_inactive), opts)
  end

  def experience
    show_inactive = (params[:show_inactive] == 'true')
    opts = { width: 800, height: 500, title: 'Experience vs Salary',
             hAxis: { title: "Years of Experience\n(Time at Bendyworks plus weighted prior experience)", minValue: 0 },
             vAxis: { title: 'Current Salary', minValue: 0 } }
    @chart = GoogleVisualr::Interactive::ScatterChart.new(experience_chart_data(show_inactive), opts)
  end

  private

  ##### History Chart methods ######

  def history_chart_data show_inactive
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('date', 'Date')

    employees = show_inactive ? Employee.all : Employee.current

    create_employee_columns!(data_table, employees)
    populate_history_chart_data!(data_table, employees)
    data_table
  end

  def create_employee_columns! data_table, employees
    employees.each do |employee|
      data_table.new_column('number', employee.first_name)
    end
  end

  def populate_history_chart_data! data_table, employees
    populate_salary_changes!(data_table, employees)
    add_salaries_today!(data_table, employees)
  end

  def populate_salary_changes! data_table, employees
    dates = Salary.ordered_dates_with_previous_dates
    data_table.add_rows(dates.count)

    dates.each_with_index do |date, date_row_num|
      data_table.set_cell(date_row_num, 0, date)

      employees.each_with_index do |employee, employee_column_num|
        data_table.set_cell(date_row_num, employee_column_num + 1, employee.salary_on(date))
      end
    end
  end

  def add_salaries_today! data_table, employees
    data_table.add_rows(1)
    row = data_table.rows.count - 1
    data_table.set_cell(row, 0, Date.today)

    employees.each_with_index do |employee, employee_column_num|
      data_table.set_cell(row, employee_column_num + 1, employee.salary_on(Date.today))
    end
  end


  ##### Experience Chart methods ######

  def experience_chart_data show_inactive
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('number', 'Years of Experience')

    employees = show_inactive ? Employee.all : Employee.current

    create_employee_columns_with_tooltips!(data_table, employees)
    populate_experience_chart_data!(data_table, employees)
    data_table
  end

  def create_employee_columns_with_tooltips! data_table, employees
    employees.each do |employee|
      data_table.new_column('number', employee.first_name)
      data_table.new_column('string', 'tooltip text', nil, 'tooltip')
    end
  end

  def populate_experience_chart_data! data_table, employees
    employees.each do |employee|
      data_table.add_rows(1)
      row = data_table.rows.count - 1
      data_table.set_cell(row, 0, employee.weighted_years_experience)

      employees.each_with_index do |em, employee_index|
        if employee == em
          y_value = employee.salary_on(Date.today)
          tooltip_text = "#{employee.first_name}:\n#{employee.all_experience_formatted}\n\$#{employee.salary_on(Date.today)} salary"
        else
          y_value = nil
          tooltip_text = nil
        end

        employee_column = employee_index * 2 + 1
        data_table.set_cell(row, employee_column, y_value)
        data_table.set_cell(row, employee_column + 1, tooltip_text)
      end
    end
  end
end
