# frozen_string_literal: true
class AddMissingForeignKeys < ActiveRecord::Migration
  def change
    add_foreign_key 'salaries', 'employees', name: 'salaries_employee_id_fk'
  end
end
