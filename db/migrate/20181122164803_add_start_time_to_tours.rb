class AddStartTimeToTours < ActiveRecord::Migration[5.1]
  def change
    add_column :tours, :start_time, :datetime
  end
end
