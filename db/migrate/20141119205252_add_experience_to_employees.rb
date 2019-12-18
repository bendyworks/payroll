# frozen_string_literal: true

class AddExperienceToEmployees < ActiveRecord::Migration[6.0]
  def change
    add_column :employees, :direct_experience, :integer, default: 0, null: false
    add_column :employees, :indirect_experience, :integer, default: 0, null: false
  end
end
