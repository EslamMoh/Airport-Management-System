class AddCountryToAirport < ActiveRecord::Migration[5.1]
  def change
    add_column :airports, :country, :string
  end
end
