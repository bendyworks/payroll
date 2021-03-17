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
      key = e.display_name
      one[key] = { id: e.id, salary: e.salary_on(one[:date]) }
    end
    one
  end

  def format_salary(salary)
    if salary
      salary_in_ks = salary / 1000
      "$#{format('%g', salary_in_ks)}K"
    end
  end
end
