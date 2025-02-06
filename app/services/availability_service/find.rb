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

      # Step 2: Find all available slots for the given date for the eligible sales managers
      available_slots = Slot.where(
        sales_manager_id: sales_manager_ids,
        booked: false
      ).where("DATE(start_date) = ?", date)

      # Step 3: Filter out overlapping slots for each sales manager
      available_slots = available_slots.includes(:sales_manager).select do |slot|
        # Check if there's any booked slot overlapping with this available slot
        overlapping_slot = Slot.where(
          sales_manager_id: slot.sales_manager_id,
          booked: true
        ).where("start_date < ? AND end_date > ?", slot.end_date, slot.start_date).exists?

        !overlapping_slot
      end

      # Step 4: Calculate available_count by checking all eligible sales managers for each slot
      available_slots_grouped = available_slots.group_by(&:start_date)

      result = available_slots_grouped.map do |start_date, slots|
        available_count = slots.count { |slot| slot.sales_manager_id.in?(sales_manager_ids) && !slot.booked }

        {
          available_count: available_count,
          start_date: start_date.iso8601(3)
        }
      end

      result
    end
  end
end
