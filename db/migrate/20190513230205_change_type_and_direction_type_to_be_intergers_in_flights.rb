class ChangeTypeAndDirectionTypeToBeIntergersInFlights < ActiveRecord::Migration[5.1]
  def change
    change_column :flights, :type, 'integer USING CAST(type AS integer)'
    change_column :flights, :direction_type, 'integer USING CAST(direction_type AS integer)'
  end
end
