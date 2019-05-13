module Api
  module Users
    module V1
      class TerminalsController < Api::BaseController
        before_action :set_terminal, only: %i[show update destroy]

        # GET /api/users/v1/terminals/:airport_id
        # fetches all terminals for specific airport by id
        def index
          terminals = scope.page(page).per(per)
          json_response(PageDecorator.decorate(terminals), :ok)
        end

        # GET /api/users/v1/terminals/:airport_id/:id
        # fetch airport terminal by id
        def show
          json_response(@terminal.decorate, :ok)
        end

        # POST /api/users/v1/terminals/:airport_id
        # create new airport terminal
        def create
          @terminal = scope.new(terminal_params)

          if @terminal.save
            json_response(@terminal.decorate, :created)
          else
            json_response(@terminal.errors, :unprocessable_entity)
          end
        end

        # PUT /api/users/v1/terminals/:airport_id/:id
        # update airport terminal by id
        def update
          if @terminal.update(terminal_params)
            json_response(@terminal.decorate, :ok)
          else
            json_response(@terminal.errors, :unprocessable_entity)
          end
        end

        # DELETE /api/users/v1/terminals/:airport_id/:id
        # remove terminal
        def destroy
          @terminal.destroy
          head :no_content
        end

        private

        def set_terminal
          @terminal = scope.find(params[:id])
        end

        def terminal_params
          params.fetch(:terminal, {}).permit(:name, :description)
        end

        def scope
          @terminals = current_user.airports.find(params[:airport_id]).terminals
        end
      end
    end
  end
end
