class CreateGuests < ActiveRecord::Migration[5.1]
  def change
    create_table :guests do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.boolean :subscribed, null: false, default: false
      t.integer :note_id

      t.timestamps
    end
  end
end
