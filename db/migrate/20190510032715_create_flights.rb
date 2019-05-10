class CreateFlights < ActiveRecord::Migration[5.1]
  def change
    create_table :flights do |t|
      t.string :name
      t.float :price
      t.string :type
      t.string :direction_type
      t.string :status
      t.string :departure_country
      t.string :destination_country
      t.references :departure_airport, index: true, foreign_key: {to_table: :airports}
      t.references :destination_airport, index: true, foreign_key: {to_table: :airports}
      t.datetime :departure_time
      t.datetime :arrival_time
      t.integer :capacity
      t.timestamps
    end
  end
end
