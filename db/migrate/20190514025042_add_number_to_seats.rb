class AddNumberToSeats < ActiveRecord::Migration[5.1]
  def change
    add_column :seats, :number, :integer
  end
end
