class FlightDecorator < Draper::Decorator
  delegate_all

  def as_json(options = {})
    {
      name: name,
      price: price
    }
  end
end
