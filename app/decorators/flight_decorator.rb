class FlightDecorator < Draper::Decorator
  delegate_all

  def as_json(options = { flight_details: false })
    output = {
      id: id,
      name: name,
      price: price,
      type: flight_type,
      status: status,
      direction_type: direction_type,
      from: departure_country,
      to: destination_country,
      departure_time: departure_time,
      arrival_time: arrival_time,
      remaining_tickets: tickets_count,
      departure_airport: departure_airport.try(:decorate).try(:as_json),
      destination_airport: destination_airport.try(:decorate).try(:as_json)
    }

    if options[:flight_details]
      output[:flight_details] = flight_executions.try(:decorate).try(:as_json)
    end
    output
  end
end
