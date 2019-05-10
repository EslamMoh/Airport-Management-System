class Api::Passenger::FlightsController < Api::BaseController
  before_action :set_api_passenger_flight, only: [:show, :edit, :update, :destroy]

  # GET /api/passenger/flights
  # GET /api/passenger/flights.json
  def index
    @api_passenger_flights = Flight.all.page(page).per(per)
    render json: PageDecorator.decorate(@api_passenger_flights)
  end

  # GET /api/passenger/flights/1
  # GET /api/passenger/flights/1.json
  def show
  end

  # GET /api/passenger/flights/new
  def new
    @api_passenger_flight = Flight.new
  end

  # GET /api/passenger/flights/1/edit
  def edit
  end

  # POST /api/passenger/flights
  # POST /api/passenger/flights.json
  def create
    @api_passenger_flight = Flight.new(api_passenger_flight_params)

    respond_to do |format|
      if @api_passenger_flight.save
        format.html { redirect_to @api_passenger_flight, notice: 'Flight was successfully created.' }
        format.json { render :show, status: :created, location: @api_passenger_flight }
      else
        format.html { render :new }
        format.json { render json: @api_passenger_flight.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api/passenger/flights/1
  # PATCH/PUT /api/passenger/flights/1.json
  def update
    respond_to do |format|
      if @api_passenger_flight.update(api_passenger_flight_params)
        format.html { redirect_to @api_passenger_flight, notice: 'Flight was successfully updated.' }
        format.json { render :show, status: :ok, location: @api_passenger_flight }
      else
        format.html { render :edit }
        format.json { render json: @api_passenger_flight.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/passenger/flights/1
  # DELETE /api/passenger/flights/1.json
  def destroy
    @api_passenger_flight.destroy
    respond_to do |format|
      format.html { redirect_to api_passenger_flights_url, notice: 'Flight was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_passenger_flight
      @api_passenger_flight = Flight.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def api_passenger_flight_params
      params.fetch(:api_passenger_flight, {})
    end
end
