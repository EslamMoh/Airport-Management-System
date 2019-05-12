class PassengerDecorator < Draper::Decorator
  delegate_all

  def as_json
    {
      id: id,
      name: name,
      phone: phone,
      country: country,
      address: address,
      email: email,
      birth_date: birth_date
    }
  end
end
