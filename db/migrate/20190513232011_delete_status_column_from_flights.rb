class DeleteStatusColumnFromFlights < ActiveRecord::Migration[5.1]
  def change
    remove_column :flights, :status
  end
end
