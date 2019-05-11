class AirportDecorator < Draper::Decorator
  delegate_all

  def as_json(options = {})
    {
      id: id,
      name: name,
      city: city,
      airlines: airlines.try(:decorate).try(:as_json)
    }
  end
end