# frozen_string_literal: true

class AddMissingForeignKeys < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key 'salaries', 'employees', name: 'salaries_employee_id_fk'
  end
end
