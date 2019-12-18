# frozen_string_literal: true

class CreateBalances < ActiveRecord::Migration[6.0]
  def change
    create_table :balances do |t|
      t.references :account, index: true, foreign_key: true
      t.date :date
      t.decimal :amount

      t.timestamps null: false
    end
  end
end
