module Api
  module Users
    module V1
      class AirplanesController < Api::BaseController
        before_action :set_airplane, only: %i[show update destroy]

        # GET /api/users/v1/airplanes
        # fetches all airplanes, to add any of them later to
        # one of the flights
        def index
          airplanes = Airplane.includes(:airline).all.page(page).per(per)
          json_response(PageDecorator.decorate(airplanes)
                                     .as_json(airline_details: true), :ok)
        end

        # GET /api/users/v1/airplanes/:id
        # fetch any airplane by id
        def show
          json_response(@airplane.decorate.as_json(airline_details: true), :ok)
        end

        # POST /api/users/v1/airplanes
        # create new airline airplane
        def create
          @airplane = Airplane.new(airplane_params)

          if @airplane.save
            json_response(@airplane.decorate.as_json(airline_details: true),
                          :created)
          else
            json_response(@airplane.errors, :unprocessable_entity)
          end
        end

        # PUT /api/users/v1/airplanes/:id
        # update airline airplane by id
        def update
          if @airplane.update(airplane_params)
            json_response(@airplane.decorate.as_json(airline_details: true),
                          :ok)
          else
            json_response(@airplane.errors, :unprocessable_entity)
          end
        end

        # DELETE /api/users/v1/airplanes/:airplane_id/:id
        # remove airplane
        def destroy
          @airplane.destroy
          head :no_content
        end

        private

        def set_airplane
          @airplane = Airplane.includes(:airline).find(params[:id])
        end

        def airplane_params
          params.fetch(:airplane, {}).permit(:manufacturer, :model_number,
                                             :capacity, :weight, :airline_id)
        end
      end
    end
  end
end
