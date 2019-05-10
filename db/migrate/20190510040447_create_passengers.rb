class CreatePassengers < ActiveRecord::Migration[5.1]
  def change
    create_table :passengers do |t|
      t.string :name
      t.string :phone
      t.string :country
      t.string :address
      t.string :email
      t.string :birth_date
      t.timestamps
    end
  end
end
