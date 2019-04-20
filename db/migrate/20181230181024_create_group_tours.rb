class CreateGroupTours < ActiveRecord::Migration[5.1]
  def change
    create_table :group_tours do |t|
      t.integer :group_id
      t.integer :tour_id

      t.timestamps
    end
  end
end
