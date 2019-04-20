class CreateGroupGuests < ActiveRecord::Migration[5.1]
  def change
    create_table :group_guests do |t|
      t.integer :group_id
      t.integer :guest_id

      t.timestamps
    end
  end
end
