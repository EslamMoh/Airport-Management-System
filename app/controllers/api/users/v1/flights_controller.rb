module Api
  module Users
    module V1
      class FlightsController < Api::BaseController
        before_action :set_flight, only: %i[update destroy show]

        # GET /api/users/v1/flights
        # fetches current user flights
        def index
          flights = scope.includes(:departure_airport, :destination_airport,
                                   :flight_executions).page(page)
                         .per(per)
          json_response(PageDecorator.decorate(flights)
                                     .as_json(flight_details: true), :ok)
        end

        # GET /api/users/v1/flights/1
        # fetch flight by id
        def show
          json_response(@flight.decorate.as_json(flight_details: true), :ok)
        end

        # POST /api/users/v1/flights
        # create new flight
        def create
          @flight = scope.new(flight_params)

          if @flight.save
            json_response(@flight.decorate.as_json(flight_details: true),
                          :created)
          else
            json_response(@flight.errors, :unprocessable_entity)
          end
        end

        # PUT /api/users/v1/flights/1
        # update flight by id
        def update
          if @flight.update(flight_params)
            json_response(@flight.decorate.as_json(flight_details: true), :ok)
          else
            json_response(@flight.errors, :unprocessable_entity)
          end
        end

        # DELETE /api/users/v1/flights/1
        # delete flight by id
        def destroy
          @flight.destroy
          head :no_content
        end

        private

        def set_flight
          @flight = scope.find(params[:id])
        end

        def flight_params
          params.fetch(:flight, {}).permit(:name, :flight_type,
                                           :direction_type, :departure_country,
                                           :destination_country, :capacity,
                                           :departure_airport_id, :arrival_time,
                                           :departure_time, :price,
                                           :destination_airport_id)
        end

        def scope
          @flights = current_user.flights
        end
      end
    end
  end
end
