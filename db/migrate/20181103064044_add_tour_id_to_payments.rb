class AddTourIdToPayments < ActiveRecord::Migration[5.1]
  def change
    add_column :payments, :tour_id, :integer
  end
end
