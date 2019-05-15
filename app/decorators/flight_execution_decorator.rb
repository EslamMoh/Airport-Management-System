class FlightExecutionDecorator < Draper::Decorator
  delegate_all

  def as_json(options = {})
    {
      id: id,
      departure_country: departure_terminal.airport.country,
      departure_city: departure_terminal.airport.city,
      departure_airport: departure_terminal.airport.name,
      departure_terminal: departure_terminal.name,
      destination_country: destination_terminal.airport.country,
      destination_city: destination_terminal.airport.city,
      destination_airport: destination_terminal.airport.name,
      destination_terminal: destination_terminal.name,
      departure_time: departure_time,
      arrival_time: arrival_time,
      airline: airplane.airline.name
    }
  end
end
