module Api
  module Users
    module V1
      class AirportsController < Api::BaseController
        before_action :set_airport, only: %i[show update destroy]

        # GET /api/users/v1/airports
        # fetch all users airports
        def index
          airports = scope.page(page).per(per)
          json_response(PageDecorator.decorate(airports), :ok)
        end

        # GET /api/users/v1/airports/1
        # fetch airport by id
        def show
          json_response(@airport.decorate, :ok)
        end

        # POST /api/users/v1/airports
        # create new airport
        def create
          @airport = scope.new(airport_params)

          if @airport.save
            json_response(@airport.decorate, :created)
          else
            json_response(@airport.errors, :unprocessable_entity)
          end
        end

        # PUT /api/users/v1/airports/1
        # update airport by id
        def update
          if @airport.update(airport_params)
            json_response(@airport.decorate, :ok)
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

        private

        def set_airport
          @airport = scope.find(params[:id])
        end

        def airport_params
          params.fetch(:airport, {}).permit(:name, :city, :country)
        end

        def scope
          @airports = current_user.airports
        end
      end
    end
  end
end
