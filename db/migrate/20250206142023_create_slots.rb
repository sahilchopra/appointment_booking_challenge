class CreateSlots < ActiveRecord::Migration[7.2]
  def change
    create_table :slots do |t|
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false
      t.boolean :booked, null: false, default: false
      t.references :sales_manager, null: false, foreign_key: true
    end
  end
end
