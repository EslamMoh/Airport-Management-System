class TicketDecorator < Draper::Decorator
  delegate_all

  def as_json(options = {})
    {
      id: id,
      flight: flight.decorate.as_json,
      seats: seats.decorate.as_json(flight_details: true),
      payment_status: payment_status
    }
  end
end
