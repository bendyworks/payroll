class SalaryGraph
  attr_reader :employees, :dates

  def initialize(employees, dates)
    @employees = employees
    @dates = dates
  end

  def to_table
    dates.map do |date|
      table_row_for(date)
    end
  end

  private

  def format_date(date)
    date.to_time.to_f * 1000
  end

  def table_row_for(date)
    row = { date: format_date(date) }

    employees.each do |e|
      row[e.id] = { name: e.display_name, salary: e.salary_on(date) }
    end

    row
  end
end
