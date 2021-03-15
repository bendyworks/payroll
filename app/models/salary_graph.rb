class SalaryGraph
  attr_reader :employees, :dates

  def initialize(employees, dates)
    @employees = employees
    @dates = dates
  end

  def to_table
    dates.map do |date|
      employees_row_for({ date: date })
    end
  end

  private

  def employees_row_for(one)
    employees.each do |e|
      key = e.display_name.underscore
      one[key] = e.salary_on(one[:date])
    end
    one
  end

  def format_date(date)
    [date.to_time.to_f * 1000]
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
