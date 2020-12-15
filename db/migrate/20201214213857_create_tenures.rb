class CreateTenures < ActiveRecord::Migration[6.1]
  def change
    create_table :tenures do |t|
      t.date :start_date, null: false
      t.date :end_date
      t.references :employee

      t.timestamps
    end
  end
end
