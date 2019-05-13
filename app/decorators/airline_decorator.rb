class AirlineDecorator < Draper::Decorator
  delegate_all

  def as_json(options = { airplanes_details: false })
    output = {
      id: id,
      name: name,
      origin_country: origin_country
    }
    output['airplanes'] = airplanes.try(:decorate).try(:as_json) if options[:airplanes_details]
    output
  end
end
