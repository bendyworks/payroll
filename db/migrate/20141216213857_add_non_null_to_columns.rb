# frozen_string_literal: true
class AddNonNullToColumns < ActiveRecord::Migration
  def change
    change_column_null :employees, :start_date, false
    change_column_null :salaries, :start_date, false
    change_column_null :salaries, :annual_amount, false
    change_column_null :salaries, :employee_id, false
  end
end
