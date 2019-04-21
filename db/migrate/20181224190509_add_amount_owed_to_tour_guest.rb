class AddAmountOwedToTourGuest < ActiveRecord::Migration[5.1]
  def change
    add_column :tour_guests, :amount_owed, :decimal, precision: 8, scale: 2
  end
end
