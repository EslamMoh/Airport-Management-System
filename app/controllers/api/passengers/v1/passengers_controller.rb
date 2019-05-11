module Api
  module Passengers
    module V1
      class PassengersController < Api::BaseController
        skip_before_action :authorize_request, only: :create
        # POST /signup
        # return authenticated token upon signup
        def create
          passenger = ::Passenger.create!(passenger_params)
          auth_token = Auth::AuthenticateUser.new(passenger.email, passenger.password, 'Passenger').call
          response = { message: Message.account_created, auth_token: auth_token }
          json_response(response, :created)
        end

        private

        def passenger_params
          params.permit(
            :name,
            :email,
            :phone,
            :country,
            :address,
            :birth_date,
            :password,
            :password_confirmation
          )
        end
      end
    end
  end
end
