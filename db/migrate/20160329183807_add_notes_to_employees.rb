# frozen_string_literal: true
class AddNotesToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :notes, :text
  end
end
