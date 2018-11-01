class AddTourLocationIdToTours < ActiveRecord::Migration[5.1]
  def change
    add_column :tours, :tour_location_id, :integer
  end
end
