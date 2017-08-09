# frozen_string_literal: true

class AddMissingIndices < ActiveRecord::Migration
  def change
    add_index :accounts, :account_type_id
    add_index :salaries, :employee_id
    add_index :users, [:invited_by_id, :invited_by_type]
  end
end
