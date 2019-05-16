module Api
  module Users
    module V1
      class AirlinesController < Api::BaseController
        before_action :set_airline, only: %i[show update]

        # GET /api/users/v1/airlines
        # fetches all airlines, to add any of them later to
        # one of the owned airports
        def index
          airlines = Airline.includes(:airplanes).all.page(page).per(per)
          json_response(PageDecorator.decorate(airlines)
                                     .as_json(airplanes_details: true), :ok)
        end

        # GET /api/users/v1/airlines/:id
        # fetch any airline by id
        def show
          json_response(@airline.decorate.as_json(airplanes_details: true), :ok)
        end

        # POST /api/users/v1/airlines
        # create new airline
        def create
          @airline = Airline.new(airline_params)

          if @airline.save
            json_response(@airline.decorate.as_json(airplanes_details: true),
                          :created)
          else
            json_response(@airline.errors, :unprocessable_entity)
          end
        end

        # PUT /api/users/v1/airlines/:id
        # update airline by id
        def update
          if @airline.update(airline_params)
            json_response(@airline.decorate.as_json(airplanes_details: true),
                          :ok)
          else
            json_response(@airline.errors, :unprocessable_entity)
          end
        end

        private

        def set_airline
          @airline = Airline.find(params[:id])
        end

        def airline_params
          params.fetch(:airline, {}).permit(:name, :origin_country)
        end
      end
    end
  end
end
