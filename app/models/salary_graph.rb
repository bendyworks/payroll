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
      key = e.id
      one[key] = { name: e.display_name, salary: e.salary_on(one[:date]) }
    end
    one
  end
end
