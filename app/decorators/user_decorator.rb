class UserDecorator < Draper::Decorator
  delegate_all

  def as_json
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
