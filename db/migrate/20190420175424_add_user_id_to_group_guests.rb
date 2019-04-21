class AddUserIdToGroupGuests < ActiveRecord::Migration[5.1]
  def change
    add_column :group_guests, :user_id, :integer
  end
end
