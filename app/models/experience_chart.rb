require 'filter_employees'

class ExperienceChart
  include FilterEmployees

  attr_reader :chart

  def initialize collection_opts
    opts = { width: 800, height: 500, title: 'Experience vs Salary',
             hAxis: { title: "Years of Experience\n(Time at Bendyworks plus weighted prior experience)", minValue: 0 },
             vAxis: { title: 'Current Salary', minValue: 0 } }

    @employees = filtered_collection(collection_opts)
    @chart = GoogleVisualr::Interactive::ScatterChart.new(chart_data(collection_opts), opts)
  end

  private

  def chart_data collection_opts
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('number', 'Years of Experience')

    create_employee_columns_with_tooltips! data_table
    populate_experience_chart_data! data_table
    data_table
  end

  def create_employee_columns_with_tooltips! data_table
    @employees.each do |employee|
      data_table.new_column('number', employee.first_name)
      data_table.new_column('string', 'tooltip text', nil, 'tooltip')
    end
  end

  def populate_experience_chart_data! data_table
    @employees.each do |employee|
      add_employee_row data_table, employee
    end
  end

  def add_employee_row data_table, employee
    row_num = data_table.rows.count
    data_table.add_rows(1)
    data_table.set_cell(row_num, 0, employee.weighted_years_experience)

    @employees.each_with_index do |em, employee_index|
      if employee == em
        y_value = employee.current_or_last_pay
        tooltip_text = employee.experience_tooltip
      else
        y_value = nil
        tooltip_text = nil
      end

      employee_column = employee_index * 2 + 1
      data_table.set_cell(row_num, employee_column, y_value)
      data_table.set_cell(row_num, employee_column + 1, tooltip_text)
    end
  end
end
