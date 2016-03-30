class SalaryChart
  include FilterEmployees

  attr_reader :chart

  def initialize(collection_opts, chart_opts = nil)
    chart_opts ||= {}
    opts = { width: 800, height: 500, legend: 'right',
             vAxis: { minValue: 0, gridlines: { count: 10 } } }
    opts.merge!(chart_opts.slice(:width, :height, :legend, :title, :hAxis,
                                 :vAxis, :chartArea))
    @employees = filtered_collection(collection_opts)
    @chart = GoogleVisualr::Interactive::LineChart.new(chart_data, opts)
  end

  private

  def chart_options(chart_opts)
    chart_opts ||= {}
    opts = { width: 800, height: 500, legend: 'right',
             vAxis: { minValue: 0, gridlines: { count: 10 } } }
    opts.merge(chart_opts.slice(:width, :height, :legend))
  end

  def chart_data
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('date', 'Date')

    create_employee_columns! data_table
    populate_history_chart_data! data_table
    data_table
  end

  def create_employee_columns!(data_table)
    @employees.each do |employee|
      data_table.new_column('number', employee.first_name + "\n$" +
                                      employee.current_or_last_pay.to_i.to_s)
    end
  end

  def populate_history_chart_data!(data_table)
    populate_salary_changes! data_table
    add_salaries_today! data_table
  end

  def populate_salary_changes!(data_table)
    data_table.add_rows(salary_history_dates.count)

    salary_history_dates.each_with_index do |date, date_row_num|
      data_table.set_cell(date_row_num, 0, date)

      @employees.each_with_index do |employee, employee_column_num|
        data_table.set_cell(date_row_num, employee_column_num + 1, employee.salary_on(date))
      end
    end
  end

  def add_salaries_today!(data_table)
    data_table.add_rows(1)
    row = data_table.rows.count - 1
    data_table.set_cell(row, 0, Time.zone.today)

    @employees.each_with_index do |employee, employee_column_num|
      data_table.set_cell(row, employee_column_num + 1, employee.salary_on(Time.zone.today))
    end
  end

  def salary_history_dates
    @history_dates ||= (
      Salary.ordered_dates_with_previous_dates + Employee.ordered_start_dates
    ).sort.uniq
  end
end
