class RenameTypeInFlights < ActiveRecord::Migration[5.1]
  def change
    rename_column :flights, :type, :flight_type
  end
end
