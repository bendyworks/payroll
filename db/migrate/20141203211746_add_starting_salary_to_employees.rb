# frozen_string_literal: true

class AddStartingSalaryToEmployees < ActiveRecord::Migration[6.0]
  def change
    add_column :employees, :starting_salary, :decimal, default: 0, null: false
  end
end
