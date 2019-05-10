class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :phone
      t.string :country
      t.string :email
      t.json :details
      t.timestamps
    end
  end
end
