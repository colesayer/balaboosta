class DropTourLocation < ActiveRecord::Migration[5.1]
  def change
    drop_table :tour_locations
  end
end
