# parent of all API controller
module Api
  module Users
    class BaseController < ApplicationController
      # called before every action on controllers
      before_action :authorize_request
      attr_reader :current_user

      private

      # Check for valid request token and return user
      def authorize_request
        @current_user = (Auth::AuthorizeApiRequest.new(request.headers).call)[:user]
      end
    end
  end
end

