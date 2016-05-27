class ExperienceChart
  include FilterEmployees

  attr_reader :chart

  def initialize(collection_opts, chart_opts = nil)
    chart_opts ||= {}
    opts = { width: 800, height: 500,
             hAxis: { title: 'Years at Bendyworks plus partial prior experience', minValue: 0 },
             vAxis: { minValue: 0 } }
    opts.merge!(chart_opts.slice(:width, :height, :legend, :title, :hAxis,
                                 :vAxis, :chartArea))
    @employees = filtered_collection(collection_opts)
    @chart = GoogleVisualr::Interactive::ScatterChart.new(chart_data, opts)
  end

  private

  def chart_data
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('number', 'Years of Experience')

    create_employee_columns_with_tooltips! data_table
    populate_experience_chart_data! data_table
    data_table
  end

  def create_employee_columns_with_tooltips!(data_table)
    @employees.each do |employee|
      data_table.new_column('number', "#{employee.first_name} #{employee.display_pay}")
      data_table.new_column('string', 'tooltip text', nil, 'tooltip')
    end
  end

  def populate_experience_chart_data!(data_table)
    @employees.each do |employee|
      add_employee_row data_table, employee
    end
  end

  def add_employee_row(data_table, employee)
    row_num = data_table.rows.count
    data_table.add_rows(1)
    data_table.set_cell(row_num, 0, employee.weighted_years_experience)

    @employees.each_with_index do |em, employee_index|
      if employee == em
        add_real_employee_cell data_table, row_num, employee, employee_index
      else
        add_placeholder_employee_cell data_table, row_num, employee_index
      end
    end
  end

  def add_real_employee_cell(data_table, row_num, employee, employee_index)
    y_value = employee.current_or_last_pay
    tooltip_text = employee.experience_tooltip

    add_employee_cell data_table, row_num, employee_index, y_value, tooltip_text
  end

  def add_placeholder_employee_cell(data_table, row_num, employee_index)
    add_employee_cell data_table, row_num, employee_index, nil, nil
  end

  def add_employee_cell(data_table, row_num, employee_index, y_value, tooltip_text)
    employee_column = employee_index * 2 + 1
    data_table.set_cell(row_num, employee_column, y_value)
    data_table.set_cell(row_num, employee_column + 1, tooltip_text)
  end
end
