class CreateFlightExecutions < ActiveRecord::Migration[5.1]
  def change
    create_table :flight_executions do |t|
      t.references :flight, index: true
      t.references :airplane, index: true
      t.references :departure_terminal, index: true, foreign_key: {to_table: :terminals}
      t.references :destination_terminal, index: true, foreign_key: {to_table: :terminals}
      t.datetime :departure_time
      t.datetime :arrival_time
      t.timestamps
    end
    add_foreign_key :flight_executions, :flights
    add_foreign_key :flight_executions, :airplanes
  end
end
