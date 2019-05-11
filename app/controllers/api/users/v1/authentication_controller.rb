module Api
  module Users
    module V1
      class AuthenticationController < Api::Users::BaseController
        skip_before_action :authorize_request, only: :authenticate
        # POST auth/login
        # return auth token once user is authenticated
        def authenticate
          auth_token =
            Auth::AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
          json_response(auth_token: auth_token)
        end

        private

        def auth_params
          params.permit(:email, :password)
        end
      end
    end
  end
end
