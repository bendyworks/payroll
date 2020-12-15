class MigrateDatesToTenures < ActiveRecord::Migration[6.1]
  def up
    Employee.all.each do |employee|
      employee.tenures << Tenure.new(start_date: employee.start_date, end_date: employee.end_date)
    end

    remove_column :employees, :start_date
    remove_column :employees, :end_date
  end
  
  def down
    add_column :employees, :start_date
    add_column :employees, :end_date

    Employee.all.each do |employee|
      tenure = employee.tenures.first
      employee.update(start_date: tenure.start_date, end_date: tenure.end_date)
      employee.tenures.destroy_all
    end
  end
end
