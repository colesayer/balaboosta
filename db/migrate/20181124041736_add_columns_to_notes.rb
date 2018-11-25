class AddColumnsToNotes < ActiveRecord::Migration[5.1]
  def change
    add_column :notes, :tour_id, :integer
    add_column :notes, :tour_guest_id, :integer
  end
end
