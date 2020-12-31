class ExperienceGraph
  attr_reader :employees

  def initialize(employees)
    @employees = employees
  end

  def to_table
    employees.map.with_index do |employee, i|
      row = Array.new((@employees.length * 2) + 1)
      row[0] = employee.weighted_years_experience
      row[(2 * i) + 1] = employee.current_or_last_pay
      row[(2 * i) + 2] = experience_tooltip(employee)
      row
    end
  end

  private

  def experience_tooltip(employee)
    <<~TOOLTIP.strip
      #{employee.display_name}:
      #{employee.all_experience_formatted}
      #{employee.display_pay} salary
    TOOLTIP
  end
end
