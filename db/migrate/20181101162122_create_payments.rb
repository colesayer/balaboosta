class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.integer :user_id
      t.decimal :amount, :precision => 8, :scale => 2
      t.boolean :paid, null: false, default: false
      t.integer :note_id

      t.timestamps
    end
  end
end
