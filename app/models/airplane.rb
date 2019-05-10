class Airplane < ApplicationRecord
  belongs_to :airline
  has_many :flight_executions
end
