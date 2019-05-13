module Api
  module Passengers
    module V1
      class FlightsController < Api::BaseController
        skip_before_action :authorize_request
        before_action :set_flight, only: [:show]

        # GET /api/passengers/v1/flights
        # List all flights
        def index
          @flights = Flight.includes(:departure_airport, :destination_airport,
                                     :flight_executions).all.page(page).per(per)
          json_response(PageDecorator.decorate(@flights)
                                    .as_json(flight_details: true), :ok)
        end

        # GET /api/passengers/v1/flights/1
        # Get flight by its id
        def show
          json_response(@flight.decorate.as_json(flight_details: true), :ok)
        end

        private

        def set_flight
          @flight = Flight.find(params[:id])
        end
      end
    end
  end
end
