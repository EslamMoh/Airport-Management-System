class RemoveTicketIndexFromSeats < ActiveRecord::Migration[5.1]
  def change
    remove_index :seats, :ticket_id
  end
end
