class SeatDecorator < Draper::Decorator
  delegate_all

  def as_json
    {
      id: id,
      flight_details: flight_execution.decorate.as_json,
      status: status
    }
  end
end
