class RemoveNameFromTours < ActiveRecord::Migration[5.1]
  def change
    remove_column :tours, :name, :string
  end
end
