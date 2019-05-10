require 'rails_helper'

RSpec.describe "Api::Passenger::Flights", type: :request do
  describe "GET /api/passenger/flights" do
    it "works! (now write some real specs)" do
      get api_passenger_flights_path
      expect(response).to have_http_status(200)
    end
  end
end
