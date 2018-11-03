class CreateTourUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :tour_users do |t|
      t.integer :tour_id
      t.integer :user_id

      t.timestamps
    end
  end
end
