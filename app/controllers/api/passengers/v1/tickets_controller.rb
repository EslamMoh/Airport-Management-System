module Api
  module Passengers
    module V1
      class TicketsController < Api::BaseController
        before_action :set_ticket, only: %i[show confirm]

        # GET /api/passengers/v1/tickets
        # list all current user tickets
        def index
          tickets = scope.includes({ seats: [:flight_execution] }, :flight).all
                         .page(page).per(per)
          json_response(PageDecorator.decorate(tickets)
                                     .as_json(airport_details: true), :ok)
        end

        # GET /api/passengers/v1/tickets/1
        # fetch current user ticket by id
        def show
          json_response(@ticket.decorate, :ok)
        end

        # POST /api/passengers/v1/tickets
        # create new ticket
        def create
          @ticket = scope.new(ticket_params)

          if @ticket.save
            json_response(@ticket.decorate, :created)
          else
            json_response(@ticket.errors, :unprocessable_entity)
          end
        end

        # POST /api/passengers/v1/tickets/:id
        # confirm ticket booking by ticket id
        def confirm
          @ticket.confirm!
          json_response(@ticket.decorate, :created)
        end

        private

        def ticket_params
          params.fetch(:ticket, {}).permit(:flight_id)
        end

        def set_ticket
          @ticket = scope.find(params[:id])
        end

        def scope
          @tickets = current_user.tickets
        end
      end
    end
  end
end
