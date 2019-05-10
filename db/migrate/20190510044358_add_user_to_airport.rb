class AddUserToAirport < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :airport, index: true
    add_foreign_key :users, :airports
  end
end
