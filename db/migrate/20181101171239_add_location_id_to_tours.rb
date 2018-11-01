class AddLocationIdToTours < ActiveRecord::Migration[5.1]
  def change
    add_column :tours, :location_id, :integer
  end
end
