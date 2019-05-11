class UserDecorator < Draper::Decorator
  delegate_all

  def as_json(options = {})
    {
      id: id,
      name: name,
      phone: phone,
      country: country,
      email: email,
      details: details
    }
  end
end
