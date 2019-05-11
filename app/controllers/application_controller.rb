class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Response
  include ExceptionHandler

  # to skip protection from forgery added to application controller
  skip_before_action :verify_authenticity_token

  protected

  def page
    params[:page] || 1
  end

  def per
    params[:per] || 25
  end
end
