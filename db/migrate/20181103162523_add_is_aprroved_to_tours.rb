class AddIsAprrovedToTours < ActiveRecord::Migration[5.1]
  def change
    add_column :tours, :is_approved, :boolean, null: false, default: false
  end
end
