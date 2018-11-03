class DropTourPayments < ActiveRecord::Migration[5.1]
  def change
    drop_table :tour_payments
  end
end
