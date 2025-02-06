require 'rails_helper'

RSpec.describe AvailabilityService::Find do
  before do
    # Load seed data before the tests run (this will run the seeding process)
    load Rails.root.join('db', 'seeds.rb')
  end

  describe '#call' do
    context "Monday 2024-05-03, Solar Panels and Heatpumps, German and Gold customer" do
      it 'returns correct available slots for Seller 2' do
        service = AvailabilityService::Find.new(date: "2024-05-03", products: [ "SolarPanels", "Heatpumps" ], language: "German", rating: "Gold")
        result = service.call

        expect(result).to match_array([ { available_count: 1, start_date: "2024-05-03T10:30:00.000Z" }, { available_count: 1, start_date: "2024-05-03T11:00:00.000Z" }, { available_count: 1, start_date: "2024-05-03T11:30:00.000Z" } ])
      end
    end

    context "Monday 2024-05-03, Heatpumps, English and Silver customer" do
      it 'returns correct available slots for Seller 2 and Seller 3' do
        service = AvailabilityService::Find.new(date: "2024-05-03", products: [ "Heatpumps" ], language: "English", rating: "Silver")
        result = service.call

        expect(result).to match_array([ { available_count: 1, start_date: "2024-05-03T10:30:00.000Z" },
                                       { available_count: 1, start_date: "2024-05-03T11:00:00.000Z" },
                                       { available_count: 2, start_date: "2024-05-03T11:30:00.000Z" } ])
      end
    end

    context "Monday 2024-05-03, SolarPanels, German and Bronze customer" do
      it 'returns correct available slots for Seller 1 and Seller 2' do
        service = AvailabilityService::Find.new(date: "2024-05-03", products: [ "SolarPanels" ], language: "German", rating: "Bronze")
        result = service.call

        expect(result).to match_array([ { available_count: 1, start_date: "2024-05-03T10:30:00.000Z" },
                                       { available_count: 1, start_date: "2024-05-03T11:00:00.000Z" },
                                       { available_count: 1, start_date: "2024-05-03T11:30:00.000Z" } ])
      end
    end

    context "Tuesday 2024-05-04, Solar Panels and Heatpumps, German and Gold customer" do
      it 'returns empty as Seller 2 is fully booked' do
        service = AvailabilityService::Find.new(date: "2024-05-04", products: [ "SolarPanels", "Heatpumps" ], language: "German", rating: "Gold")
        result = service.call

        expect(result).to match_array([])
      end
    end

    context "Tuesday 2024-05-04, Heatpumps, English and Silver customer" do
      it 'returns correct available slots for Seller 3' do
        service = AvailabilityService::Find.new(date: "2024-05-04", products: [ "Heatpumps" ], language: "English", rating: "Silver")
        result = service.call

        expect(result).to match_array([ { available_count: 1, start_date: "2024-05-04T11:30:00.000Z" } ])
      end
    end
  end
end
