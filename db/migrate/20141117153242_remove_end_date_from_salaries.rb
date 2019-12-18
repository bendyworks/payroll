# frozen_string_literal: true

class RemoveEndDateFromSalaries < ActiveRecord::Migration[6.0]
  def change
    remove_column :salaries, :end_date, :date
  end
end
