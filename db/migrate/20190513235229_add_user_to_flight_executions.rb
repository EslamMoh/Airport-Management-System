class AddUserToFlightExecutions < ActiveRecord::Migration[5.1]
  def change
    add_reference :flight_executions, :user, index: true
    add_foreign_key :flight_executions, :users
  end
end
