class AddPasswordToPassengers < ActiveRecord::Migration[5.1]
  def change
    add_column :passengers, :password_digest, :string
  end
end
