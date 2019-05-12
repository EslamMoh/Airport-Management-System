class AirlineDecorator < Draper::Decorator
  delegate_all

  def as_json
    {
      id: id,
      name: name,
      origin_country: origin_country
    }
  end
end
