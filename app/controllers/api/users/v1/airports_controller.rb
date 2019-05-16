module Api
  module Users
    module V1
      class AirportsController < Api::BaseController
        before_action :set_airport, only: %i[update destroy
                                             add_airport_airlines
                                             remove_airport_airline]

        # GET /api/users/v1/airports
        # fetches all airports, to add any of them later to flight or
        # flight execution as departure or destination airport
        def index
          airports = Airport.includes(:terminals, :airlines).all.page(page)
                            .per(per)
          json_response(PageDecorator.decorate(airports)
                                     .as_json(airport_details: true), :ok)
        end

        # GET /api/users/v1/airports/1
        # fetch any airport by id, to add it later to flight or
        # flight execution as departure or destination airport
        def show
          @airport = Airport.find(params[:id])
          json_response(@airport.decorate.as_json(airport_details: true), :ok)
        end

        # POST /api/users/v1/airports
        # create new airport
        def create
          @airport = scope.new(airport_params)

          if @airport.save
            json_response(@airport.decorate.as_json(airport_details: true),
                          :created)
          else
            json_response(@airport.errors, :unprocessable_entity)
          end
        end

        # PUT /api/users/v1/airports/1
        # update airport by id
        def update
          if @airport.update(airport_params)
            json_response(@airport.decorate.as_json(airport_details: true), :ok)
          else
            json_response(@airport.errors, :unprocessable_entity)
          end
        end

        # DELETE /api/users/v1/airports/1
        # delete airport by id
        def destroy
          @airport.destroy
          head :no_content
        end

        # POST /api/users/v1/airports/airlines/:id/:airline_id
        # add airlines to airport by ids
        def add_airport_airlines
          @airport.airlines << Airline.find(params[:airline_id])
          json_response(@airport.decorate.as_json(airport_details: true), :ok)
        end

        # DELETE /api/users/v1/airports/airlines/:id/:airline_id
        # remove airline from airport by ids
        def remove_airport_airline
          airline = @airport.airlines.find(params[:airline_id])
          @airport.airlines.delete(airline)
          head :no_content
        end

        private

        def set_airport
          @airport = scope.find(params[:id])
        end

        def airport_params
          params.fetch(:airport, {}).permit(:name, :city, :country)
        end

        def scope
          @airports = current_user.airports.includes(:airlines, :terminals)
        end
      end
    end
  end
end
