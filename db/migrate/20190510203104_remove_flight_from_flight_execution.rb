class RemoveFlightFromFlightExecution < ActiveRecord::Migration[5.1]
  def change
    remove_column :flight_executions, :flight_id
  end
end
