# frozen_string_literal: true

class AddMissingIndices < ActiveRecord::Migration[6.0]
  def change
    add_index :accounts, :account_type_id unless index_exists?(:accounts, :account_type_id)
    add_index :salaries, :employee_id unless index_exists?(:salaries, :employee_id)
    invited_by_params = [:invited_by_id, :invited_by_type]
    add_index :users, invited_by_params unless index_exists?(:users, invited_by_params)
  end
end
