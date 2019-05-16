class ChangeCapacityNameInFlights < ActiveRecord::Migration[5.1]
  def change
    rename_column :flights, :capacity, :tickets_count
  end
end
