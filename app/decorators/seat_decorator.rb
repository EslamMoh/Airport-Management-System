class SeatDecorator < Draper::Decorator
  delegate_all

  def as_json(options = {})
    {
      id: id,
      ticket: ticket.try(:decorate).try(:as_json),
      flight_details: flight_execution.decorate.as_json,
      status: status
    }
  end
end
