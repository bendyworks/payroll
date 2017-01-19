# frozen_string_literal: true
class CreateSalaries < ActiveRecord::Migration
  def change
    create_table :salaries do |t|
      t.date :start_date
      t.date :end_date
      t.references :employee
      t.decimal :annual_amount

      t.timestamps
    end
  end
end
