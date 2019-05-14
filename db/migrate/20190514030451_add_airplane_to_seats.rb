class AddAirplaneToSeats < ActiveRecord::Migration[5.1]
  def change
    add_reference :seats, :airplane, index: true
    add_foreign_key :seats, :airplanes
  end
end
