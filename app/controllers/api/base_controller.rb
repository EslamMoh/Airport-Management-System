# parent of all API controller
module Api
  class BaseController < ApplicationController

    protected

    def page
      params[:page] || 1
    end

    def per
      params[:per] || 25
    end
  end
end