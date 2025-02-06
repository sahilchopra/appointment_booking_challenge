# frozen_string_literal: true

require "dry-initializer"
require "dry-types"

module AvailabilityService
  class Find
    extend Dry::Initializer

    option :date, Types::String
    option :products, Types::Array.of(Types::String)
    option :language, Types::String
    option :rating, Types::String

    def call
      # Step 1: Find eligible Sales Managers
      sales_manager_ids = SalesManager.where(
        "languages @> ARRAY[?]::varchar[] AND products @> ARRAY[?]::varchar[] AND customer_ratings @> ARRAY[?]::varchar[]",
        language, products, rating
      ).pluck(:id)

      # Step 2: Find available slots, filter out overlapping slots, and group by start_date
      available_slots = Slot
                          .where(
                            sales_manager_id: sales_manager_ids,
                            booked: false,
                            start_date: DateTime.parse(date).beginning_of_day..DateTime.parse(date).end_of_day
                          )
                          .where.not(
                            id: Slot
                                  .joins("INNER JOIN slots AS overlapping_slots ON slots.sales_manager_id = overlapping_slots.sales_manager_id")
                                  .where("overlapping_slots.booked = TRUE")
                                  .where("overlapping_slots.start_date < slots.end_date")
                                  .where("overlapping_slots.end_date > slots.start_date")
                                  .select("slots.id")
                          )
                          .group(:start_date)
                          .select("start_date, COUNT(id) AS available_count")


      # Format the result
      available_slots.map do |slot|
        {
          available_count: slot.available_count,
          start_date: slot.start_date.iso8601(3)
        }
      end
    end
  end
end
