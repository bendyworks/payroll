# frozen_string_literal: true

class SetBillableDefaultTrue < ActiveRecord::Migration[6.0]
  def up
    change_column :employees, :billable, :boolean, default: true
  end

  def down
    change_column :employees, :billable, :boolean, default: nil
  end
end
