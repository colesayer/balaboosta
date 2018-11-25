class DropNoteIdFromTables < ActiveRecord::Migration[5.1]
  def change
    remove_column :guests, :note_id, :integer
    remove_column :payments, :note_id, :integer
    remove_column :tours, :note_id, :integer
    remove_column :tour_guests, :note_id, :integer
  end
end
