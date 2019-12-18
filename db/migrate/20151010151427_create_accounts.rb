# frozen_string_literal: true

class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.string :name
      t.references :account_type

      t.timestamps null: false
    end
  end
end
