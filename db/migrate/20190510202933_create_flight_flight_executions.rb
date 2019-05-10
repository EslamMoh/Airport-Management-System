class CreateFlightFlightExecutions < ActiveRecord::Migration[5.1]
  def change
    create_table :flight_flight_executions do |t|
      t.references :flight, index: true
      t.references :flight_execution, index: true
      t.timestamps
    end
    add_foreign_key :flight_flight_executions, :flights
    add_foreign_key :flight_flight_executions, :flight_executions
  end
end
