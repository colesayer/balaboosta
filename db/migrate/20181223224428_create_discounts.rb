class CreateDiscounts < ActiveRecord::Migration[5.1]
  def change
    create_table :discounts do |t|
      t.decimal :percentage_amount, :precision => 6, :scale => 5
      t.string :name

      t.timestamps
    end
  end
end
