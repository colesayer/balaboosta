class AddNetAmountToTours < ActiveRecord::Migration[5.1]
  def change
    add_column :tours, :net_amount, :decimal, precision: 8, scale: 2
  end
end
