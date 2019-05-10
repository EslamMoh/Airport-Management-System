class Api::Passenger::FlightsController < Api::BaseController
  before_action :set_flight, only: [:show]

  def index
    @flights = Flight.all.page(page).per(per)
    render json: PageDecorator.decorate(@flights)
  end

  def show
    render json: @flight.decorate
  end

  private

  def set_flight
    @flight = Flight.find(params[:id])
  end
end
