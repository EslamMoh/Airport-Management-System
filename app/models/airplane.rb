class Airplane < ApplicationRecord
  # Model associations
  belongs_to :airline
  has_many :flight_executions

  # validations
  validates :manufacturer, :model_number, :capacity, presence: true
  validates :model_number, uniqueness: true
end
