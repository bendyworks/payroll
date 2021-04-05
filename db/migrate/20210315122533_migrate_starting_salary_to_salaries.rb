class MigrateStartingSalaryToSalaries < ActiveRecord::Migration[6.1]
  def up
    add_reference :salaries, :tenure, foreign_key: true

    Employee.all.each do |employee|
      Salary.where(employee_id: employee.id).all.each do |salary|
        # look for tenure date range containing salary start_date.  Fall back to first if none found
        tenure = employee.tenures.where(
          'start_date <= :date and (end_date >= :date or end_date is NULL)',
          date: salary.start_date).first
        tenure = employee.tenures.first unless tenure
        salary.update(tenure_id: tenure.id)
      end
      tenure = employee.tenures.first
      tenure.salaries << Salary.new(
        start_date: tenure.start_date,
        annual_amount: employee.attributes['starting_salary'],
        employee_id: employee.id)
      tenure.save!
    end

    remove_reference :salaries, :employee, foreign_key: true
    remove_column :employees, :starting_salary
  end

  def down
    add_column :employees, :starting_salary, :decimal, default: 0, null: false
    add_reference :salaries, :employee, foreign_key: true

    Employee.all.each do |employee|
      employee.tenures.each do |tenure|
        tenure.salaries.each { |salary| salary.update(employee_id: employee.id) }
      end
      tenure = employee.tenures.first
      salary = tenure.salaries.first if tenure
      employee.update(starting_salary: salary.annual_amount) if salary
      salary.destroy!
    end

    remove_reference :salaries, :tenure
  end
end
