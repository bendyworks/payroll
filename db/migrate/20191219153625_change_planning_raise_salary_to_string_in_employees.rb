class ChangePlanningRaiseSalaryToStringInEmployees < ActiveRecord::Migration[6.0]
  def up
    change_column :employees, :planning_raise_salary, :string
  end
  def down
    change_column :employees, :planning_raise_salary, :decimal
  end
end
