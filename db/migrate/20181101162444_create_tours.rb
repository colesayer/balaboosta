class CreateTours < ActiveRecord::Migration[5.1]
  def change
    create_table :tours do |t|
      t.string :date
      t.string :name
      t.decimal :base_price, :precision => 8, :scale => 2
      t.string :start_time
      t.boolean :is_private, null: false, default: false
      t.integer :note_id

      t.timestamps
    end
  end
end
