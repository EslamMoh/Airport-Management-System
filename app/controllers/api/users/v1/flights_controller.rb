module Api
  module Users
    module V1
      class FlightsController < Api::BaseController
        before_action :set_flight, only: %i[update destroy show
                                            add_flight_executions
                                            remove_flight_execution]

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

        # POST /api/users/v1/flights/flight_executions/:flight_id
        # add any flight executions to current users flight
        def add_flight_executions
          @flight.flight_executions << FlightExecution
                                       .where(id: flight_execution_params['flight_executions_ids'])
          json_response(@flight.decorate.as_json(flight_details: true),
                        :created)
        end

        # DELETE /api/users/v1/flights/flight_executions/:flight_id/:flight_execution_id
        # remove flight execution from current users flight
        def remove_flight_execution
          flight_execution = FlightExecution.find(params[:flight_execution_id])
          @flight.flight_executions.delete(flight_execution)
          head :no_content
        end

        private

        def set_flight
          @flight = scope.find(params[:id])
        end

        def flight_params
          params.fetch(:flight, {}).permit(:name, :flight_type,
                                           :direction_type, :departure_country,
                                           :destination_country, :tickets_count,
                                           :departure_airport_id, :arrival_time,
                                           :departure_time, :price,
                                           :destination_airport_id)
        end

        def flight_execution_params
          params.permit(flight_executions_ids: [])
        end

        def scope
          @flights = current_user.flights
        end
      end
    end
  end
end
