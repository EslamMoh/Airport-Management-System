class SeatDecorator < Draper::Decorator
  delegate_all

  def as_json(options = { passenger_details: false, flight_details: false })
    output = {
      id: id,
      number: number,
      status: status
    }

    if options[:flight_details]
      output[:flight_details] = flight_execution.try(:decorate).try(:as_json)
    end

    if options[:passenger_details]
      output[:passenger_details] = ticket.passenger.try(:decorate).try(:as_json)
    end
    output
  end
end
