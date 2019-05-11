# parent of all API controller
module Api
  class BaseController < ApplicationController
    # called before every action on controllers
    before_action :authorize_request
    attr_reader :current_user

    private

    # Check for valid request token and return user
    def authorize_request
      user_type = if controller_path.include? 'api/users/v1'
                    'User'
                  elsif controller_path.include? 'api/passengers/v1'
                    'Passenger'
                  end
      @current_user = (Auth::AuthorizeApiRequest.new(request.headers, user_type).call)[:user]
    end
  end
end
