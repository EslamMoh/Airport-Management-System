class CreateAirportAirlines < ActiveRecord::Migration[5.1]
  def change
    create_table :airport_airlines do |t|
      t.references :airport, index: true
      t.references :airline, index: true
      t.timestamps
    end
    add_foreign_key :airport_airlines, :airports
    add_foreign_key :airport_airlines, :airlines
  end
end
