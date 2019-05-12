class TerminalDecorator < Draper::Decorator
  delegate_all

  def as_json
    {
      id: id,
      name: name,
      description: description
    }
  end
end
