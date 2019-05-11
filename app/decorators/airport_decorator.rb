class AirportDecorator < Draper::Decorator
  delegate_all

  def as_json(options = {})
    {
      name: name,
      city: city
    }
  end
end
