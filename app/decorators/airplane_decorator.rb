class AirplaneDecorator < Draper::Decorator
  delegate_all

  def as_json
    {
      id: id,
      manufacturer: manufacturer,
      model_number: model_number,
      capacity: capacity,
      weight: weight,
      airline: airline.decorate.as_json
    }
  end
end
