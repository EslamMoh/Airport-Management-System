class TicketDecorator < Draper::Decorator
  delegate_all

  def as_json(options = { passenger_details: false })
    output = {
      id: id,
      flight: flight.decorate.as_json,
      seats: seats.decorate.as_json(flight_details: true),
      payment_status: payment_status
    }

    if options[:passenger_details]
      output[:passenger_details] = passenger.try(:decorate).try(:as_json)
    end
    output
  end
end
