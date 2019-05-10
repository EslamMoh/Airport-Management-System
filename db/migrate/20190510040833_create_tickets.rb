class CreateTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets do |t|
      t.references :flight, index: true
      t.references :passenger, index: true
      t.string :payment_status
      t.timestamps
    end
    add_foreign_key :tickets, :flights
    add_foreign_key :tickets, :passengers
  end
end
