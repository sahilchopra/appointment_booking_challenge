class CreateSalesManagers < ActiveRecord::Migration[7.2]
  def change
    create_table :sales_managers do |t|
      t.string :name, null: false
      t.string :languages, array: true, default: []
      t.string :products, array: true, default: []
      t.string :customer_ratings, array: true, default: []
    end
  end
end
