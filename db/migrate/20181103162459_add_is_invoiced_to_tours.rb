class AddIsInvoicedToTours < ActiveRecord::Migration[5.1]
  def change
    add_column :tours, :is_invoiced, :boolean, null: false, default: false
  end
end
