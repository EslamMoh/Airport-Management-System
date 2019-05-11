class Api::Passenger::FlightsController < Api::BaseController
  before_action :set_flight, only: [:show]

  def index
    @flights = Flight.includes(:departure_airport, :destination_airport).all.page(page).per(per)
    render json: PageDecorator.decorate(@flights).as_json(flight_details: true)
  end

  def show
    render json: @flight.decorate.as_json(flight_details: true)
  end

  private

  def set_flight
    @flight = Flight.find(params[:id])
  end
end
