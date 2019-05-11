class Airplane < ApplicationRecord
  # Model associations
  belongs_to :airline
  has_many :flight_executions
end
