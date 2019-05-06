class CreateTerminals < ActiveRecord::Migration[5.1]
  def change
    create_table :terminals do |t|
      t.string :name
      t.string :description
      t.references :airport, index: true
      t.timestamps
    end
    add_foreign_key :terminals, :airports
  end
end
