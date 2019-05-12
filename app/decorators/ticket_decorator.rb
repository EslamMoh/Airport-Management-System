class TicketDecorator < Draper::Decorator
  delegate_all

  def as_json
    {
      id: id,
      flight: flight.decorate.as_json,
      seats: seats.decorate.as_json,
      payment_status: payment_status
    }
  end
end
