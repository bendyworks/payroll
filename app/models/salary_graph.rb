class SalaryGraph
  attr_reader :employees, :dates

  def initialize(employees, dates)
    @employees = employees
    @dates = dates
  end

  def to_table
    dates.map do |date|
      # Multiply by 1000 to convert from seconds since the epoch to
      # milliseconds since the epoch
      format_date(date) + employees_row_for(date)
    end
  end

  private

  def format_date(date)
    [date.to_time.to_f * 1000]
  end

  def employees_row_for(date)
    employees.map { |e| [e.salary_on(date), tooltip_for_date(e, date)] }.flatten
  end

  def tooltip_for_date(employee, date)
    "#{date}\n#{employee.display_name}: #{format_salary(employee.salary_on(date))}"
  end

  def format_salary(salary)
    if salary
      salary_in_ks = salary / 1000
      "$#{format('%g', salary_in_ks)}K"
    end
  end
end
