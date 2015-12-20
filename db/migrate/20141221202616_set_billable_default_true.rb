class SetBillableDefaultTrue < ActiveRecord::Migration
  def up
    change_column :employees, :billable, :boolean, default: true
  end

  def down
    change_column :employees, :billable, :boolean, default: nil
  end
end
