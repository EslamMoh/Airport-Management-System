class CreateAirplanes < ActiveRecord::Migration[5.1]
  def change
    create_table :airplanes do |t|
      t.string :manufacturer
      t.string :model_number
      t.integer :capacity
      t.integer :weight
      t.timestamps
    end
  end
end
