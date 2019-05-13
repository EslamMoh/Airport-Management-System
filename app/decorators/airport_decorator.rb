class AirportDecorator < Draper::Decorator
  delegate_all

  def as_json(options = { airport_details: false })
    output = {
      id: id,
      name: name,
      city: city
    }

    if options[:airport_details]
      output[:airport_details] = {
        airlines: airlines.try(:decorate).try(:as_json),
        terminals: terminals.try(:decorate).try(:as_json)
      }
    end
    output
  end
end
