class CreateTourPayments < ActiveRecord::Migration[5.1]
  def change
    create_table :tour_payments do |t|
      t.integer :tour_id
      t.integer :payment_id

      t.timestamps
    end
  end
end
