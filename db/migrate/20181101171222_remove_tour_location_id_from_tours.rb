class RemoveTourLocationIdFromTours < ActiveRecord::Migration[5.1]
  def change
    remove_column :tours, :tour_location_id, :integer
  end
end
