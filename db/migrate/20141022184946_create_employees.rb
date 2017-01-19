# frozen_string_literal: true
class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.date :start_date
      t.date :end_date
      t.boolean :billable

      t.timestamps
    end
  end
end
