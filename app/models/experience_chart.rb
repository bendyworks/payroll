require 'filter_employees'

class ExperienceChart
  include FilterEmployees

  attr_reader :chart

  def initialize collection_opts
    opts = { width: 800, height: 500, title: 'Experience vs Salary',
             hAxis: { title: "Years of Experience\n(Time at Bendyworks plus weighted prior experience)", minValue: 0 },
             vAxis: { title: 'Current Salary', minValue: 0 } }
    @chart = GoogleVisualr::Interactive::ScatterChart.new(experience_chart_data(collection_opts), opts)
  end

  private

  def experience_chart_data collection_opts
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('number', 'Years of Experience')

    @experience_employees = filtered_collection(collection_opts)

    create_employee_columns_with_tooltips! data_table
    populate_experience_chart_data! data_table
    data_table
  end

  def create_employee_columns_with_tooltips! data_table
    @experience_employees.each do |employee|
      data_table.new_column('number', employee.first_name)
      data_table.new_column('string', 'tooltip text', nil, 'tooltip')
    end
  end

  def populate_experience_chart_data! data_table
    @experience_employees.each do |employee|
      data_table.add_rows(1)
      row = data_table.rows.count - 1
      data_table.set_cell(row, 0, employee.weighted_years_experience)

      @experience_employees.each_with_index do |em, employee_index|
        if employee == em
          y_value = employee.salary_on(Date.today) || employee.ending_salary || employee.starting_salary
          tooltip_text = "#{employee.first_name}:\n#{employee.all_experience_formatted}\n\$#{y_value} salary"
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
