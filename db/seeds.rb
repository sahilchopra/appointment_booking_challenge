# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Ensure Sales Managers exist
[
  { name: 'Seller 1', languages: [ 'German' ], products: [ 'SolarPanels' ], customer_ratings: [ 'Bronze' ] },
  { name: 'Seller 2', languages: [ 'German', 'English' ], products: [ 'SolarPanels', 'Heatpumps' ], customer_ratings: [ 'Gold', 'Silver', 'Bronze' ] },
  { name: 'Seller 3', languages: [ 'German', 'English' ], products: [ 'Heatpumps' ], customer_ratings: [ 'Gold', 'Silver', 'Bronze' ] }
].each do |sales_manager_data|
  SalesManager.find_or_create_by!(name: sales_manager_data[:name]) do |sales_manager|
    sales_manager.languages = sales_manager_data[:languages]
    sales_manager.products = sales_manager_data[:products]
    sales_manager.customer_ratings = sales_manager_data[:customer_ratings]
  end
end

# Ensure Slots exist
[
  { sales_manager_id: 1, booked: false, start_date: '2024-05-03T10:30Z', end_date: '2024-05-03T11:30Z' },
  { sales_manager_id: 1, booked: true,  start_date: '2024-05-03T11:00Z', end_date: '2024-05-03T12:00Z' },
  { sales_manager_id: 1, booked: false, start_date: '2024-05-03T11:30Z', end_date: '2024-05-03T12:30Z' },
  { sales_manager_id: 2, booked: false, start_date: '2024-05-03T10:30Z', end_date: '2024-05-03T11:30Z' },
  { sales_manager_id: 2, booked: false, start_date: '2024-05-03T11:00Z', end_date: '2024-05-03T12:00Z' },
  { sales_manager_id: 2, booked: false, start_date: '2024-05-03T11:30Z', end_date: '2024-05-03T12:30Z' },
  { sales_manager_id: 3, booked: true,  start_date: '2024-05-03T10:30Z', end_date: '2024-05-03T11:30Z' },
  { sales_manager_id: 3, booked: false, start_date: '2024-05-03T11:00Z', end_date: '2024-05-03T12:00Z' },
  { sales_manager_id: 3, booked: false, start_date: '2024-05-03T11:30Z', end_date: '2024-05-03T12:30Z' },
  { sales_manager_id: 1, booked: false, start_date: '2024-05-04T10:30Z', end_date: '2024-05-04T11:30Z' },
  { sales_manager_id: 1, booked: false, start_date: '2024-05-04T11:00Z', end_date: '2024-05-04T12:00Z' },
  { sales_manager_id: 1, booked: true,  start_date: '2024-05-04T11:30Z', end_date: '2024-05-04T12:30Z' },
  { sales_manager_id: 2, booked: true,  start_date: '2024-05-04T10:30Z', end_date: '2024-05-04T11:30Z' },
  { sales_manager_id: 2, booked: false, start_date: '2024-05-04T11:00Z', end_date: '2024-05-04T12:00Z' },
  { sales_manager_id: 2, booked: true,  start_date: '2024-05-04T11:30Z', end_date: '2024-05-04T12:30Z' },
  { sales_manager_id: 3, booked: true,  start_date: '2024-05-04T10:30Z', end_date: '2024-05-04T11:30Z' },
  { sales_manager_id: 3, booked: false, start_date: '2024-05-04T11:00Z', end_date: '2024-05-04T12:00Z' },
  { sales_manager_id: 3, booked: false, start_date: '2024-05-04T11:30Z', end_date: '2024-05-04T12:30Z' }
].each do |slot_data|
  Slot.find_or_create_by!(sales_manager_id: SalesManager.find_by(name: "Seller #{slot_data[:sales_manager_id]}").id, start_date: slot_data[:start_date]) do |slot|
    slot.end_date = slot_data[:end_date]
    slot.booked = slot_data[:booked]
  end
end
