class AddUserToFlights < ActiveRecord::Migration[5.1]
  def change
    add_reference :flights, :user, index: true
    add_foreign_key :flights, :users
  end
end
