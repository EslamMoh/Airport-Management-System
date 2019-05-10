class CreateSeats < ActiveRecord::Migration[5.1]
  def change
    create_table :seats do |t|
      t.references :ticket, index: true
      t.references :flight_execution, index: true
      t.string :status
      t.timestamps
    end
    add_foreign_key :seats, :tickets
    add_foreign_key :seats, :flight_executions
  end
end
