class ExperienceGraph
  attr_reader :employees

  def initialize(employees)
    @employees = employees
  end

  def to_table
    employees.map do |employee|
      table_row_for(employee)
    end
  end

  private

  def table_row_for(employee)
    {
      id: employee.id,
      name: employee.display_name,
      experience: employee.weighted_years_experience,
      salary: employee.current_or_last_pay
    }
  end
end
