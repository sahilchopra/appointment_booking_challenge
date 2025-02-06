# spec/requests/available_slots_spec.rb

require 'rails_helper'

RSpec.describe "AvailableSlots", type: :request do
  before(:all) do
    # Load seed data before the tests run (this will run the seeding process)
    load Rails.root.join('db', 'seeds.rb')
  end

  describe "POST /calendar/query" do
    context "when the request is valid" do
      it "returns available slots with status 200" do
        # Assuming we have some test data in the database
        post "/calendar/query", params: {
          date: "2024-05-03",
          products: [ "SolarPanels", "Heatpumps" ],
          language: "German",
          rating: "Gold"
        }

        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        # Check that the response body contains the expected available slots (adjust according to your test data)
        expect(json_response).to be_an(Array)
        expect(json_response.first).to have_key('available_count')
        expect(json_response.first).to have_key('start_date')
      end
    end

    context "when the request is invalid" do
      it "returns error if date is missing" do
        post "/calendar/query", params: {
          products: [ "SolarPanels" ],
          language: "English",
          rating: "Gold"
        }

        expect(response).to have_http_status(422)
        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to eq("Invalid request parameters")
      end

      it "returns error if products is not an array" do
        post "/calendar/query", params: {
          date: "2024-05-03",
          products: "SolarPanels",  # Not an array
          language: "English",
          rating: "Gold"
        }

        expect(response).to have_http_status(422)
        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to eq("Invalid request parameters")
      end

      it "returns error if an invalid product is passed" do
        post "/calendar/query", params: {
          date: "2024-05-03",
          products: [ "InvalidProduct" ],
          language: "English",
          rating: "Gold"
        }

        expect(response).to have_http_status(422)
        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to eq("Invalid request parameters")
      end

      it "returns error if language is invalid" do
        post "/calendar/query", params: {
          date: "2024-05-03",
          products: [ "SolarPanels" ],
          language: "French",  # Invalid language
          rating: "Gold"
        }

        expect(response).to have_http_status(422)
        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to eq("Invalid request parameters")
      end

      it "returns error if rating is invalid" do
        post "/calendar/query", params: {
          date: "2024-05-03",
          products: [ "SolarPanels" ],
          language: "English",
          rating: "Platinum"  # Invalid rating
        }

        expect(response).to have_http_status(422)
        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to eq("Invalid request parameters")
      end
    end
  end
end
