# frozen_string_literal: true

class AddMissingIndices < ActiveRecord::Migration[6.0]
  def change
    add_index :accounts, :account_type_id unless index_exists?(:accounts, :account_type_id)
    add_index :salaries, :employee_id
    add_index :users, [:invited_by_id, :invited_by_type]
  end
end
