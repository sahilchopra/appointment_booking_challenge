# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_02_06_142023) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "sales_managers", force: :cascade do |t|
    t.string "name", null: false
    t.string "languages", default: [], array: true
    t.string "products", default: [], array: true
    t.string "customer_ratings", default: [], array: true
  end

  create_table "slots", force: :cascade do |t|
    t.datetime "start_date", null: false
    t.datetime "end_date", null: false
    t.boolean "booked", default: false, null: false
    t.bigint "sales_manager_id", null: false
    t.index ["sales_manager_id"], name: "index_slots_on_sales_manager_id"
  end

  add_foreign_key "slots", "sales_managers"
end
