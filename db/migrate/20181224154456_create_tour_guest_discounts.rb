class CreateTourGuestDiscounts < ActiveRecord::Migration[5.1]
  def change
    create_table :tour_guest_discounts do |t|
      t.integer :tour_guest_id
      t.integer :discount_id
      t.integer :num_ppl

      t.timestamps
    end
  end
end
