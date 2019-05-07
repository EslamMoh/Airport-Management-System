class AddAirlineToAirplanes < ActiveRecord::Migration[5.1]
  def change
    add_reference :airplanes, :airline, index: true
    add_foreign_key :airplanes, :airlines
  end
end
