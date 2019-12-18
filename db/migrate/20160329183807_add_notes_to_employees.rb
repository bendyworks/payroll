# frozen_string_literal: true

class AddNotesToEmployees < ActiveRecord::Migration[6.0]
  def change
    add_column :employees, :notes, :text
  end
end
