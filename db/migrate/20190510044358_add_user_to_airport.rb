class AddUserToAirport < ActiveRecord::Migration[5.1]
  def change
    add_reference :airports, :user, index: true
    add_foreign_key :airports, :users
  end
end
