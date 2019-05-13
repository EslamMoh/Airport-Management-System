module Api
  module Users
    module V1
      class AirlinesController < Api::BaseController
        before_action :set_airline, only: %i[show update]

        # GET /api/users/v1/airlines
        # fetches all airlines, to add any of them later to
        # one of the owned airports
        def index
          airlines = Airline.all.page(page).per(per)
          json_response(PageDecorator.decorate(airlines), :ok)
        end

        # POST /api/users/v1/airport_airlines/:airport_id/:id
        # add airlines to airport by ids
        def add_airport_airlines
          scope.airlines << Airline.find(params[:id])
          json_response(scope.decorate.as_json(airport_details: true), :ok)
        end

        # GET /api/users/v1/airlines/:id
        # fetch any airline by id
        def show
          json_response(@airline.decorate, :ok)
        end

        # POST /api/users/v1/airlines
        # create new airline
        def create
          @airline = Airline.new(airline_params)

          if @airline.save
            json_response(@airline.decorate, :created)
          else
            json_response(@airline.errors, :unprocessable_entity)
          end
        end

        # PUT /api/users/v1/airlines/:id
        # update airline by id
        def update
          if @airline.update(airline_params)
            json_response(@airline.decorate, :ok)
          else
            json_response(@airline.errors, :unprocessable_entity)
          end
        end

        # DELETE /api/users/v1/airlines/:airport_id/:id
        # remove airline from airport by ids
        def destroy
          airline = scope.airlines.find(params[:id])
          scope.airlines.delete(airline)
          head :no_content
        end

        private

        def set_airline
          @airline = Airline.find(params[:id])
        end

        def airline_params
          params.fetch(:airline, {}).permit(:name, :origin_country)
        end

        def scope
          @airports = current_user.airports.find(params[:airport_id])
        end
      end
    end
  end
end
