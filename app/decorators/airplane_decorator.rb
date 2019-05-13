class AirplaneDecorator < Draper::Decorator
  delegate_all

  def as_json(options = { airline_details: false })
    output = {
      id: id,
      manufacturer: manufacturer,
      model_number: model_number,
      capacity: capacity,
      weight: weight
    }
    output['airline'] = airline.decorate.as_json if options[:airline_details]
    output
  end
end
