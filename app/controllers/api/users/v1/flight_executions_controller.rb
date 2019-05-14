module Api
  module Users
    module V1
      class FlightExecutionsController < Api::BaseController
        before_action :set_flight_execution, only: %i[update destroy show]

        # GET /api/users/v1/flight_executions
        # fetches current user flight executions
        def index
          flight_executions = scope.includes({ departure_terminal: [:airport] },
                                             { destination_terminal: [:airport] },
                                             :airplane).page(page).per(per)
          json_response(PageDecorator.decorate(flight_executions), :ok)
        end

        # GET /api/users/v1/flight_executions/1
        # fetch flight execution by id
        def show
          json_response(@flight_execution.decorate, :ok)
        end

        # POST /api/users/v1/flight_executions
        # create new flight execution
        def create
          @flight_execution = scope.new(flight_execution_params)

          if @flight_execution.save
            json_response(@flight_execution.decorate, :created)
          else
            json_response(@flight_execution.errors, :unprocessable_entity)
          end
        end

        # PUT /api/users/v1/flight_executions/1
        # update flight execution by id
        def update
          if @flight_execution.update(flight_execution_params)
            json_response(@flight_execution.decorate, :ok)
          else
            json_response(@flight_execution.errors, :unprocessable_entity)
          end
        end

        # DELETE /api/users/v1/flight_executions/1
        # delete flight execution by id
        def destroy
          @flight_execution.destroy
          head :no_content
        end

        private

        def set_flight_execution
          @flight_execution = scope.find(params[:id])
        end

        def flight_execution_params
          params.fetch(:flight_execution, {}).permit(:airplane_id,
                                                     :arrival_time,
                                                     :departure_time,
                                                     :destination_terminal_id,
                                                     :departure_terminal_id)
        end

        def scope
          @flight_executions = current_user.flight_executions
        end
      end
    end
  end
end
