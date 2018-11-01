class CreateTourGuests < ActiveRecord::Migration[5.1]
  def change
    create_table :tour_guests do |t|
      t.integer :tour_id
      t.integer :guest_id
      t.integer :num_guests
      t.integer :user_id
      t.boolean :is_confirmed, null: false, default: false
      t.boolean :is_cancelled, null: false, default: false
      t.integer :note_id
      
      t.timestamps
    end
  end
end
