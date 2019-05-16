module Api
  module Users
    module V1
      class TicketsController < Api::BaseController
        before_action :set_flight
        before_action :set_passenger, only: %i[create]

        # GET /api/users/v1/tickets/:flight_id
        # list all current user flight tickets by flight id
        def index
          tickets = @flight.tickets.includes({ seats: [:flight_execution] },
                                             :flight, :passenger).all
                           .page(page).per(per)
          json_response(PageDecorator.decorate(tickets)
                                     .as_json(passenger_details: true), :ok)
        end

        # POST /api/users/v1/tickets
        # create new ticket
        def create
          if @passenger.blank?
            json_response({ message: 'Sorry, This is not a registered passenger' },
                          :not_found)
            return
          end
          @ticket = @passenger.tickets.new(flight: @flight)

          if @ticket.save
            json_response(@ticket.decorate.as_json(passenger_details: true),
                          :created)
          else
            json_response(@ticket.errors, :unprocessable_entity)
          end
        end

        private

        def ticket_params
          params.permit(:flight_id, :email)
        end

        def set_passenger
          @passenger = ::Passenger.find_by(email: params[:email])
        end

        def set_flight
          @flight = scope.find(params[:flight_id])
        end

        def scope
          @flights = current_user.flights
        end
      end
    end
  end
end
