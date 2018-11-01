class CreateTourLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :tour_locations do |t|
      t.string :name

      t.timestamps
    end
  end
end
