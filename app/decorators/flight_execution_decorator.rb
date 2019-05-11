class FlightExecutionDecorator < Draper::Decorator
  delegate_all

  def as_json(options = {})
    {
      id: id,
      departure_airport: departure_terminal.airport.name,
      departure_terminal: departure_terminal.name,
      destination_airport: destination_terminal.airport.name,
      destination_terminal: destination_terminal.name,
      departure_time: departure_time,
      arrival_time: arrival_time,
      airline: airplane.airline.name
    }
  end
end
